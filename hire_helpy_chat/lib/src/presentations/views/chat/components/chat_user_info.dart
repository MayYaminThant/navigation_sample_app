import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dh_employer/src/config/routes/routes.dart';
import 'package:dh_employer/src/core/utils/configs_key_helper.dart';
import 'package:dh_employer/src/domain/entities/entities.dart';
import 'package:dh_employer/src/presentations/views/chat/components/complaint_violation_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import '../../candidate/components/employer_flag.dart';
import '../../../../core/params/params.dart';
import '../../../../core/utils/db_utils.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/utils/string_utils.dart';
import '../../../../data/models/models.dart';
import '../../../blocs/blocs.dart';
import '../../../values/values.dart';
import '../../contact_us/components/message_sent_pop_up.dart';
import '../../my_account/components/error_pop_up.dart';
import 'chat_details_menu.dart';

class ChatUserInfo extends StatefulWidget {
  const ChatUserInfo(
      {super.key, required this.conversationId, this.conversation});

  final String conversationId;
  final ZIMKitConversation? conversation;

  @override
  State<ChatUserInfo> createState() => _ChatUserInfoState();
}

class _ChatUserInfoState extends State<ChatUserInfo> {
  Candidate? candidate;
  String basePhotoUrl = '';
  Map? employerData;
  List<String> _profileComplainList = [];

  @override
  void initState() {
    _getPhotoUrl();
    _getCandidateData();
    _getComplainProfile();
    super.initState();
  }

  _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      employerData = box.get(DBUtils.employerTableName);
    });
    requestPublicCandidateProfile();
  }

  void _getPhotoUrl() async {
    String data = await DBUtils.getEmployerConfigs(DBUtils.stroagePrefix);
    setState(() {
      basePhotoUrl = data;
    });
  }

  _getComplainProfile() async {
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
    return BlocConsumer<CandidateBloc, CandidateState>(
      builder: (_, state) {
        return candidate != null ? _getUserInfo : Container();
      },
      listener: (_, state) {
        if (state is CandidatePublicProfileSuccess) {
          if (state.candidateData.data != null) {
            setState(() {
              candidate =
                  CandidateModel.fromJson(state.candidateData.data!['data']);
            });
          }
        }

        if (state is CandidatePublicProfileFail) {
          if (state.message != '') {
            showInfoModal(message: state.message, type: 'error');
          }
        }
      },
    );
  }

  //ImageView
  Widget get _getUserProfile => CachedNetworkImage(
        imageUrl: '$basePhotoUrl/${candidate!.user!.avatar ?? ''}',
        imageBuilder: (context, imageProvider) => Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(25.0)),
              color: AppColors.white,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              )),
        ),
        placeholder: (context, url) => const SizedBox(
          width: 50,
          height: 50,
          child: Center(child: CircularProgressIndicator()),
        ),
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
            _listenEmployerData
          ],
        ),
      );

  Widget get _getTopItem => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            StringUtils.getFullName(candidate!.user!.firstName ?? '',
                candidate!.user!.lastName ?? ''),
            style: const TextStyle(
                color: AppColors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700),
          ),
          CheckDetailMenuDropDown(
              conversationId: widget.conversationId,
              onValueChanged: (value) {
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
                  country: candidate!.user!.nationality ?? '',
                  configKey: ConfigsKeyHelper.profileStep1PhoneKey),
              const SizedBox(
                width: 10,
              ),
              Text(
                candidate!.user!.nationality ?? '',
                style: const TextStyle(
                    color: AppColors.primaryGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => Get.toNamed(candidateProfilePageRoute, arguments: {
              'id': widget.conversationId,
            }),
            child: const Text(
              StringConst.viewDetailsText,
              style: TextStyle(
                color: Color(0xffC4D9FD),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      );

  requestPublicCandidateProfile() {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidatePublicProfileRequestParams params =
        CandidatePublicProfileRequestParams(
            candidateId: int.parse(widget.conversationId));
    candidateBloc.add(CandidatePublicProfileRequested(params: params));
  }

  _onClickMenu(String value) {
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
                builder: (BuildContext context) {
                  return DraggableScrollableSheet(
                    expand: false,
                    initialChildSize: 0.7,
                    builder: (context, scrollController) {
                      return ComplaintViolationModal(
                        controller: scrollController,
                        token: employerData!['token'],
                        userId: int.parse(widget.conversationId.toString()),
                        conversationId: widget.conversationId,
                        conversation: widget.conversation,
                      );
                    },
                  );
                },
              )
            : showInfoModal(
                type: 'error',
                message: "You already complainted this profile.");
        break;

      case 'Clear Messages':
        _clearZimMessage();
        break;

      case 'Hire this Helper through Phluid NOW':
        Get.toNamed(hiringPageRoute, arguments: {
          "conversation": widget.conversation,
          "candidateId": widget.conversationId
        });
        break;

      case 'Comment on Candidate':
        Get.toNamed(reviewsPageRoute, parameters: {
          DBUtils.employerTableName: json.encode(candidate).toString()
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

  get _listenEmployerData => BlocConsumer<EmployerBloc, EmployerState>(
        builder: (_, state) {
          return Container();
        },
        listener: (_, state) {
          if (state is EmployerProfileComplaintSuccess) {
            if (state.data.data != null) {
              _showSuccessInfo();
              _profileComplainList.add(widget.conversationId);
              _saveComplainProfile('complained_profiles', _profileComplainList);
            }
          }

          if (state is EmployerProfileComplaintFail) {
            if (state.message != '') {
              showInfoModal(message: state.message, type: 'error');
            }
          }
        },
      );

  void _saveComplainProfile(String name, List<String> list) async {
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
                content: Builder(
                  builder: (context) {
                    return Container(
                        color: AppColors.greyBg,
                        height: 207,
                        width: 326,
                        child: const MessageSentPopUp(
                            title: 'Thanks for submitting your review.',
                            message: 'we love to hear from you.'));
                  },
                ),
              ));
    }).then((value) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context, rootNavigator: true).pop();
      });
    });
  }
}
