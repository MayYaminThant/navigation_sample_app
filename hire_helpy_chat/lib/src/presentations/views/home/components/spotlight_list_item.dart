import 'package:cached_network_image/cached_network_image.dart';
import 'package:dh_employer/src/config/routes/routes.dart';
import 'package:dh_employer/src/core/utils/configs_key_helper.dart';
import 'package:dh_employer/src/core/utils/db_utils.dart';
import 'package:dh_employer/src/presentations/values/values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../candidate/components/employer_flag.dart';
import '../../candidate/components/jobs_info.dart';
import '../../../../core/utils/string_utils.dart';
import '../../../../domain/entities/entities.dart';

class HomeListItem extends StatefulWidget {
  const HomeListItem(
      {super.key,
      required this.candidate,
      required this.candidateList,
      required this.index});

  final Candidate candidate;
  final List<Candidate> candidateList;
  final int index;

  @override
  State<HomeListItem> createState() => _HomeListItemState();
}

class _HomeListItemState extends State<HomeListItem> {
  String? basePhotoUrl;

  @override
  void initState() {
    _getPhotoUrl();
    super.initState();
  }

  void _getPhotoUrl() async {
    String data = await DBUtils.getEmployerConfigs(DBUtils.stroagePrefix);
    setState(() {
      basePhotoUrl = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _getHomeListItem(context);
  }

  _getHomeListItem(context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(candidateProfilePageRoute, arguments: {
          'id': widget.candidate.id,
          'list': widget.candidateList,
          'index': widget.index
        });
      },
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      EmployerFlag(
                        size: 20,
                        marginValue: 0,
                        country:
                            widget.candidate.user!.nationality ?? 'Singapore',
                        configKey: ConfigsKeyHelper.profileStep1PhoneKey,
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 110,
                        child: Text(
                          StringUtils.getShortName(
                              widget.candidate.user!.firstName ?? '',
                              widget.candidate.user!.lastName ?? ''),
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
                      widget.candidate.bidData == null ||
                              StringUtils.salaryStringIsZero(
                                  widget.candidate.bidData?.salary)
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
                                        '${widget.candidate.bidData!.salary.toString()}\t',
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
              candidate: widget.candidate,
              fontSize: 10,
              paddingSize: 7,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ])),
      ),
    );
  }

  //Employeer Profile
  get _getProfilePhoto => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Stack(
          children: [
            basePhotoUrl != null
                ? CachedNetworkImage(
                    imageUrl: '$basePhotoUrl/${widget.candidate.user!.avatar}',
                    imageBuilder: (context, imageProvider) => Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          image: basePhotoUrl == null
                              ? null
                              : DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover)),
                    ),
                    placeholder: (context, url) => const SizedBox(
                      width: 70,
                      height: 70,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  )
                : const SizedBox(
                    width: 70,
                    height: 70,
                    child: Center(child: CircularProgressIndicator())),
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
        ),
      );
}
