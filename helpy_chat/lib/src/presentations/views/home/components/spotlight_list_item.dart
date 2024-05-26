import 'dart:convert';
import 'package:dh_mobile/src/config/routes/routes.dart';
import 'package:dh_mobile/src/core/utils/configs_key_helper.dart';
import 'package:dh_mobile/src/presentations/values/values.dart';
import 'package:dh_mobile/src/presentations/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/string_utils.dart';
import '../../../../domain/entities/entities.dart';
import '../../employeer/components/employer_flag.dart';
import '../../employeer/components/jobs_info.dart';

class SpotlightListItem extends StatefulWidget {
  const SpotlightListItem(
      {super.key,
      required this.employer,
      required this.employerList,
      required this.index,
      required this.basePhotoUrl});

  final Employer employer;
  final List<Employer> employerList;
  final int index;
  final String basePhotoUrl;

  @override
  State<SpotlightListItem> createState() => _SpotlightListItemState();
}

class _SpotlightListItemState extends State<SpotlightListItem> {
  @override
  Widget build(BuildContext context) {
    return _getHomeListItem(context);
  }

  Widget _getHomeListItem(context) {
    return GestureDetector(
        onTap: () => Get.toNamed(employeerProfilePageRoute, parameters: {
              'id': widget.employer.id.toString(),
              'list': jsonEncode(widget.employerList),
              'index': widget.index.toString()
            }),
        child: Container(
          margin: const EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
            color: AppColors.cardColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _getProfilePhoto,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          EmployerFlag(
                            size: 20,
                            marginValue: 0,
                            country: widget.employer.user!.nationality ??
                                'Singapore',
                            configKey: ConfigsKeyHelper.profileStep1PhoneKey,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          SizedBox(
                            width: 110,
                            child: Text(
                              StringUtils.getShortName(
                                  widget.employer.user!.firstName ?? '',
                                  widget.employer.user!.lastName ?? ''),
                              style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text.rich(
                          widget.employer.offer == null ||
                                  StringUtils.salaryStringIsZero(
                                      widget.employer.offer?.salary)
                              ? TextSpan(
                                  text: 'Unspecified Salary'.tr,
                                  style: const TextStyle(
                                      color: AppColors.primaryGrey,
                                      fontWeight: FontWeight.w300),
                                )
                              : TextSpan(
                                  children: [
                                    TextSpan(
                                        text:
                                            '${widget.employer.offer!.salary.toString()}\t',
                                        style: const TextStyle(
                                            color: AppColors.primaryColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900)),
                                    TextSpan(
                                      text: 'per month'.tr,
                                      style: const TextStyle(
                                          color: AppColors.primaryGrey,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: JobsInfo(
                  employer: widget.employer,
                  fontSize: 10,
                  paddingSize: 7,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ]),
          ),
        ));
  }

  //Employeer Profile
  Widget get _getProfilePhoto {
    final String imageUrl =
        "${widget.basePhotoUrl}/${widget.employer.user!.avatar}";
    return CustomImageView(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        radius: const BorderRadius.all(Radius.circular(10.0)),
        width: 82,
        height: 82,
        color: AppColors.white,
        image: imageUrl,
        fit: BoxFit.cover);
  }
}
