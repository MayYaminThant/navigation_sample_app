import 'package:cached_network_image/cached_network_image.dart';
import 'package:dh_employer/src/core/utils/configs_key_helper.dart';
import 'package:dh_employer/src/core/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/utils/db_utils.dart';
import '../../../../domain/entities/entities.dart';
import '../../../values/values.dart';
import 'employer_flag.dart';

class CandidateInfo extends StatefulWidget {
  const CandidateInfo(
      {super.key,
      required this.candidate,
      this.onPressed,
      this.onStarDeletePressed,
      required this.isStarList});

  final Candidate candidate;
  final VoidCallback? onPressed;
  final VoidCallback? onStarDeletePressed;
  final bool isStarList;

  @override
  State<CandidateInfo> createState() => _CandidateInfoState();
}

class _CandidateInfoState extends State<CandidateInfo> {
  Map? candidateData;
  bool isShowConnect = false;
  String basePhotoUrl = '';
  int? starId = 0;

  @override
  void initState() {
    _getCandidateData();
    _getPhotoUrl();
    super.initState();
  }

  void _getPhotoUrl() async {
    String data = await DBUtils.getEmployerConfigs(DBUtils.stroagePrefix);
    setState(() {
      basePhotoUrl = data;
    });
  }

  _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      candidateData = box.get(DBUtils.employerTableName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _getCandidateProfile,
        const SizedBox(
          width: 10,
        ),
        _getCandidateOfferInfo,
      ],
    );
  }

  get _getCandidateProfile => Stack(
        children: [
          CachedNetworkImage(
            imageUrl: '$basePhotoUrl/${widget.candidate.user!.avatar}',
            imageBuilder: (context, imageProvider) => Container(
              width: 82,
              height: 82,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover)),
            ),
            placeholder: (context, url) => const SizedBox(
              width: 82,
              height: 82,
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
          widget.candidate.workPermitStatus != null &&
                  widget.candidate.workPermitStatus == 'Verified'
              ? Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(10.0)),
                      ),
                      child: const Icon(
                        Iconsax.verify,
                        color: AppColors.white,
                        size: 18,
                      )))
              : const SizedBox.shrink()
        ],
      );

  SizedBox get _getCandidateOfferInfo => SizedBox(
        width: MediaQuery.of(context).size.width - 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    EmployerFlag(
                      country:
                          widget.candidate.user!.nationality ?? 'Singapore',
                      configKey: ConfigsKeyHelper.profileStep1PhoneKey,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        StringUtils.getShortName(
                            widget.candidate.user!.firstName ?? '',
                            widget.candidate.user!.lastName ?? ''),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryGrey.withOpacity(0.7)),
                      ),
                    )
                  ],
                ),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     widget.onPressed != null
                //         ? GestureDetector(
                //             onTap: widget.onPressed,
                //             child: const Icon(
                //               Iconsax.message,
                //               size: 24,
                //               color: AppColors.white,
                //             ),
                //           )
                //         : Container(),
                //     const SizedBox(
                //       width: 20,
                //     ),
                //     GestureDetector(
                //       onTap: widget.onStarDeletePressed ??
                //           () => _checkValidation(),
                //       child: Icon(
                //         isStared ? Iconsax.star1 : Iconsax.star4,
                //         size: isStared ? 36 : 24,
                //         color:
                //             isStared ? AppColors.primaryColor : AppColors.white,
                //       ),
                //     )
                //   ],
                // )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: widget.candidate.bidData == null ||
                      StringUtils.salaryStringIsZero(
                          widget.candidate.bidData?.salary)
                  ? Text('Unspecified Salary'.tr,
                      style: const TextStyle(
                          color: AppColors.primaryGrey,
                          fontWeight: FontWeight.w300))
                  : Text(
                      widget.candidate.bidData!.salary.toString(),
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
        ),
      );
}
