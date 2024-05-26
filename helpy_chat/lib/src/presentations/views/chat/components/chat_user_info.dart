import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dh_mobile/src/config/routes/routes.dart';
import 'package:dh_mobile/src/core/utils/configs_key_helper.dart';
import 'package:dh_mobile/src/domain/entities/entities.dart';
import 'package:dh_mobile/src/presentations/views/chat/components/complaint_violation_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import '../../../../core/params/params.dart';
import '../../../../core/utils/db_utils.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/utils/string_utils.dart';
import '../../../../data/models/models.dart';
import '../../../blocs/blocs.dart';
import '../../../values/values.dart';
import '../../contact_us/components/message_sent_pop_up.dart';
import '../../employeer/components/employer_flag.dart';
import '../../my_account/components/error_pop_up.dart';
import 'chat_details_menu.dart';

class ChatUserInfo extends StatefulWidget {
  const ChatUserInfo({super.key, required this.conversationId});

  final String conversationId;

  @override
  State<ChatUserInfo> createState() => _ChatUserInfoState();
}

class _ChatUserInfoState extends State<ChatUserInfo> {
  Employer? employer;
  String basePhotoUrl = '';
  Map? candidateData;
  List<String> _profileComplainList = [];

  @override
  void initState() {
    _initLoad();
    super.initState();
  }

  Future<void> _initLoad() async {
    await _getPhotoUrl();
    await _getCandidateData();
    await _getComplainProfile();
  }

  Future<void> _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      candidateData = box.get(DBUtils.candidateTableName);
    });
    requestPublicCandidateProfile();
  }

  Future<void> _getPhotoUrl() async {
    String? data = await DBUtils.getCandidateConfigs(DBUtils.stroagePrefix);
    if (data != null) {
      setState(() {
        basePhotoUrl = data;
      });
    }
  }

  Future<void> _getComplainProfile() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    List<String>? profileComplainCacheData = box.get('complained_profiles');

    if (profileComplainCacheData != null) {
      setState(() {
        _profileComplainList = profileComplainCacheData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployerBloc, EmployerState>(
      builder: (_, state) {
        return employer != null ? _getUserInfo : Container();
      },
      listener: (_, state) {
        if (state is EmployerPublicProfileSuccess) {
          if (state.employerData.data != null) {
            setState(() {
              employer =
                  EmployerModel.fromJson(state.employerData.data!['data']);
            });
          }
        }

        if (state is EmployerPublicProfileFail) {
          if (state.message != '') {
            showInfoModal( message: state.message, type: 'error');
          }
        }
      },
    );
  }

  //ImageView
  Widget get _getUserProfile => Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(25.0)),
            color: AppColors.white,
            image: DecorationImage(
              image: CachedNetworkImageProvider(
                '$basePhotoUrl/${employer!.user!.avatar ?? ''}',
              ),
              fit: BoxFit.cover,
            )),
      );

  //User Info
  Widget get _getUserInfo => Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: Column(
          children: [
            Row(
              children: [
                _getUserProfile,
                const SizedBox(
                  width: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  width: MediaQuery.of(context).size.width - 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      _getTopItem,
                      const SizedBox(
                        height: 5,
                      ),
                      _getBottomItem,

                      //Text('${employer!.user!.firstName} and you are connected on 14/7/2023', style: TextStyle(color: AppColors.backgroundGrey),),
                    ],
                  ),
                ),
              ],
            ),
            _listenCandidateData
          ],
        ),
      );

  Widget get _getTopItem => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            StringUtils.getFullName(employer!.user!.firstName ?? '',
                employer!.user!.lastName ?? ''),
            style: const TextStyle(
                color: AppColors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700),
          ),
          CheckDetailMenuDropDown(onValueChanged: (value) {
            _onClickMenu(value);
          })
        ],
      );

  Widget get _getBottomItem => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              EmployerFlag(
                  country: employer!.user!.nationality ?? '',
                  configKey: ConfigsKeyHelper.profileStep1PhoneKey),
              const SizedBox(
                width: 10,
              ),
              Text(
                employer!.user!.nationality ?? '',
                style: const TextStyle(
                    color: AppColors.primaryGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(employeerProfilePageRoute, parameters: {
                'id': widget.conversationId.toString(),
              });
            },
            child: Text(
              StringConst.viewDetailsText.tr,
              style: const TextStyle(
                color: Color(0xffC4D9FD),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      );

  void requestPublicCandidateProfile() {
    final candidateBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerPublicProfileRequestParams params =
        EmployerPublicProfileRequestParams(
            employerId: int.parse(widget.conversationId));
    candidateBloc.add(EmployerPublicProfileRequested(params: params));
  }

  void _onClickMenu(String value) {
    switch (value) {
      case StringConst.complaintViolationTitle:
        !_profileComplainList.contains(widget.conversationId)
            ? showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25.0))),
                context: context,
                enableDrag: true,
                isDismissible: true,
                isScrollControlled: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                builder: (BuildContext context) => StatefulBuilder(
                    builder: (context, setState) => DraggableScrollableSheet(
                          expand: false,
                          initialChildSize: 0.65,
                          builder: (context, scrollController) =>
                              ComplaintViolationModal(
                                  conversationId: widget.conversationId,
                                  controller: scrollController,
                                  token: candidateData!['token'],
                                  userId: int.parse(
                                      widget.conversationId.toString())),
                        )),
              )
            : showInfoModal(
                type: 'error',
                message: "You already complainted this profile.");
        break;

      case 'Clear Messages':
        _clearZimMessage();
        break;

      case 'Comment on Employer':
        Get.toNamed(reviewsPageRoute, parameters: {
          DBUtils.candidateTableName: json.encode(employer).toString(),
          "isFromChat": "true"
        });
        break;

      default:
        break;
    }
  }

  void _clearZimMessage() {
    showDialog(
        context: context,
        builder: (context) => ErrorPopUp(
              title: 'Are you sure to clear all messages?',
              onAgreePressed: () {
                ZIMKit().deleteConversation(
                    widget.conversationId, ZIMConversationType.peer,
                    isAlsoDeleteMessages: true);
                Navigator.pop(context);
              },
            ));
  }

  Widget get _listenCandidateData =>
      BlocConsumer<CandidateBloc, CandidateState>(
        builder: (_, state) {
          return Container();
        },
        listener: (_, state) {
          if (state is CandidateProfileComplaintSuccess) {
            if (state.data.data != null) {
              _showSuccessInfo();
              _profileComplainList.add(widget.conversationId);
              _saveComplainProfile('complained_profiles', _profileComplainList);
            }
          }

          if (state is CandidateProfileComplaintFail) {
            if (state.message != '') {
              showInfoModal( message: state.message, type: 'error');
            }
          }
        },
      );

  Future<void> _saveComplainProfile(String name, List<String> list) async {
    Box box = await Hive.openBox(DBUtils.dbName);
    box.put(name, list);

    _getComplainProfile();
  }

  void _showSuccessInfo() {
    Future.delayed(const Duration(milliseconds: 500), () {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
                backgroundColor: AppColors.greyBg,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                content: Container(
                    color: AppColors.greyBg,
                    height: 207,
                    width: 326,
                    child: const MessageSentPopUp(
                        title: 'Thanks for submitting your review.',
                        message: 'we love to hear from you.')),
              ));
    }).then((value) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context, rootNavigator: true).pop();
      });
    });
  }
}
