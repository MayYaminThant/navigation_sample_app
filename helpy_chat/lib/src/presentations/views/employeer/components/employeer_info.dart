import 'package:cached_network_image/cached_network_image.dart';
import 'package:dh_mobile/src/core/utils/configs_key_helper.dart';
import 'package:dh_mobile/src/core/utils/string_utils.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../../core/utils/db_utils.dart';
import '../../../../domain/entities/entities.dart';
import '../../../values/values.dart';
import 'employer_flag.dart';

class EmployerInfo extends StatefulWidget {
  const EmployerInfo({super.key,
    required this.employer,
    required this.isStarList});

  final Employer employer;
  final bool isStarList;

  @override
  State<EmployerInfo> createState() => _EmployerInfoState();
}

class _EmployerInfoState extends State<EmployerInfo> {
  Map? candidateData;
  bool isShowConnect = false;
  String basePhotoUrl = '';
  int? starId = 0;

  @override
  void initState() {
    _initLoad();
    super.initState();
  }

  Future<void> _initLoad() async {
    await _getCandidateData();
    await _getPhotoUrl();
  }

  Future<void> _getPhotoUrl() async {
    String data = await DBUtils.getCandidateConfigs(DBUtils.stroagePrefix);
    setState(() {
      basePhotoUrl = data;
    });
  }

  Future<void> _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      candidateData = box.get(DBUtils.candidateTableName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _getEmployerProfile,
        const SizedBox(
          width: 10,
        ),
        _getEmployerOfferInfo,
      ],
    );


    // return BlocConsumer<CandidateBloc, CandidateState>(builder: (_, state) {
    //   return _getEmployeerInfo;
    // }, listener: (_, state) {
    //   if (state is CandidateStarListAddSuccess) {
    //     if (state.data.data != null) {
    //       showSuccessSnackBar(context, state.data.data!['message']);
    //       _requestStarsList();
    //     }
    //   }
    //   if (state is CandidateStarListAddFail) {
    //     if (state.message != '') {
    //       showErrorSnackBar(context, state.message);
    //     }
    //   }
    //
    //   if (state is CandidateStarListSuccess) {
    //     if (state.data.data != null) {
    //       List<StarList> dataList = List<StarList>.from((state
    //               .data.data!['data'] as List<dynamic>)
    //           .map((e) => StarListModel.fromJson(e as Map<String, dynamic>)));
    //
    //       if (dataList.indexWhere((f) => f.onUserId == widget.employer.id) !=
    //           -1) {
    //         setState(() {
    //           isStared = true;
    //           starId = dataList[dataList
    //                   .indexWhere((f) => f.onUserId == widget.employer.id)]
    //               .id;
    //         });
    //       }
    //     }
    //   }
    //   if (state is CandidateStarListFail) {
    //     if (state.message != '') {
    //       showErrorSnackBar(context, state.message);
    //     }
    //   }
    //
    //   if (state is CandidateStarListRemoveSuccess) {
    //     if (state.data.data != null) {
    //       showSuccessSnackBar(context, state.data.data!['message']);
    //       setState(() {
    //         isStared = false;
    //       });
    //       _requestStarsList();
    //     }
    //   }
    //   if (state is CandidateStarListRemoveFail) {
    //     if (state.message != '') {
    //       showErrorSnackBar(context, state.message);
    //     }
    //   }
    // });
  }

  //Employeer Profile
  Container get _getEmployerProfile {
    return Container(
      width: 82,
      height: 82,
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          image: DecorationImage(
              image: CachedNetworkImageProvider(
                '$basePhotoUrl/${widget.employer.user!.avatar}',
              ),
              fit: BoxFit.cover)),
    );
  }

  //Employerr Offer Info
  Widget get _getEmployerOfferInfo {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                EmployerFlag(
                  country: widget.employer.user!.nationality ?? 'Singapore',
                  configKey: ConfigsKeyHelper.profileStep1PhoneKey,
                ),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.3,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    StringUtils.getShortName(
                        widget.employer.user!.firstName ?? '',
                        widget.employer.user!.lastName ?? ''),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryGrey.withOpacity(0.7)),
                  ),
                )
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: widget.employer.offer == null ||
              StringUtils.salaryStringIsZero(widget.employer.offer?.salary)
              ? Text('Unspecified Salary'.tr,
              style: const TextStyle(
                  color: AppColors.primaryGrey,
                  fontWeight: FontWeight.w300))
              : Text(
            widget.employer.offer!.salary.toString(),
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryColor),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
