import 'dart:convert';

import 'package:dh_employer/src/core/utils/constants.dart';
import 'package:dh_employer/src/presentations/views/candidate/components/candidate_info.dart';
import 'package:dh_employer/src/presentations/views/candidate/components/candidate_profile_actions.dart';
import 'package:dh_employer/src/presentations/views/candidate/components/jobs_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../config/routes/routes.dart';
import '../../../../core/utils/db_utils.dart';
import '../../../../core/utils/loading.dart';
import '../../../../core/utils/shortlink.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../domain/entities/entities.dart';
// ignore: library_prefixes
import '../../../blocs/blocs.dart' as kConnection;
import '../../../values/values.dart';
import '../../../widgets/image_slider.dart';
import 'employment_item.dart';
import 'rating_item.dart';

class CandidateProfileItem extends StatefulWidget {
  const CandidateProfileItem(
      {super.key,
      required this.candidate,
      this.onChatPressed,
      this.onStarPressed,
      required this.isStarList,
      required this.isShowConnect,
      this.isBottomBar});
  final Candidate candidate;
  final VoidCallback? onChatPressed;
  final VoidCallback? onStarPressed;
  final bool isShowConnect;
  final bool isStarList;
  final bool? isBottomBar;

  @override
  State<CandidateProfileItem> createState() => _CandidateProfileItemState();
}

class _CandidateProfileItemState extends State<CandidateProfileItem> {
  List<String> languageList = [];
  List<String> skillList = [];
  String workPermitStatus = 'Not Verified';
  bool isStared = false;

  @override
  void initState() {
    _addLanguages();
    _addSkills();
    workPermitStatus = widget.candidate.workPermitStatus ?? 'Not Verified';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<kConnection.ConnectionBloc,
        kConnection.ConnectionState>(builder: (_, state) {
      return _getEmployeeProfileContainer();
    }, listener: (_, state) {
      if (state is kConnection.ConnectionSendRequestLoading) {
        Loading.showLoading(message: StringConst.loadingText);
      }
      if (state is kConnection.ConnectionSendRequestSuccess) {
        Loading.cancelLoading();
        if (state.connectionData.data != null) {
          showSuccessSnackBar(state.connectionData.data!['message']);
        }
      }
      if (state is kConnection.ConnectionSendRequestFail) {
        Loading.cancelLoading();
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  //Candidate Profile
  _getEmployeeProfileContainer() => Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: widget.isBottomBar != null && widget.isBottomBar!
                ? MediaQuery.of(context).size.height - 220
                : MediaQuery.of(context).size.height - 180,
            child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _getAvalibilityStatus(),
                      CandidateInfo(
                        candidate: widget.candidate,
                        isStarList: widget.isStarList,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      JobsInfo(
                        candidate: widget.candidate,
                        fontSize: 15,
                        paddingSize: 10,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CandidateProfileActions(
                          candidate: widget.candidate,
                          onChatPressed: widget.onChatPressed,
                          onStarPressed: widget.onStarPressed,
                          onSharePressed: _onSharePressed,
                          isStarList: widget.isStarList),
                      const SizedBox(
                        height: 25,
                      ),
                      _buildImages(),
                      const SizedBox(
                        height: 15,
                      ),
                      _buildContentText(),
                      const SizedBox(
                        height: 20,
                      ),
                      buildItemInformation(
                          StringConst.languageInformationText, languageList),
                      const SizedBox(
                        height: 20,
                      ),
                      buildItemInformation(
                        StringConst.familyInformationText,
                        [
                          _getFamilyInformation(),
                          _getSiblingInfo(),
                          _getFamilyMembers()
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      buildItemInformation(StringConst.qualificationsText, [
                        widget.candidate.highestQualification != null
                            ? "${widget.candidate.highestQualification ?? ''} ${widget.candidate.educationJourneyDesc != null && widget.candidate.educationJourneyDesc != '' ? '(${widget.candidate.educationJourneyDesc})' : ''}"
                            : '',
                      ]),
                      const SizedBox(
                        height: 20,
                      ),
                      buildWorkPermitValidity(),
                      buildItemInformation(StringConst.skillText, skillList),
                      const SizedBox(
                        height: 20,
                      ),
                      buildHeaderWorkingExperience(),
                      const SizedBox(
                        height: 20,
                      ),
                      _getWorkExperienceListView,
                      const SizedBox(
                        height: 20,
                      ),
                      buildItemInformation(
                        StringConst.workingPreferencesText,
                        _getWorkingPreferences(),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(bottom: 10, right: 20, left: 20, child: _getRating),
          if (widget.isShowConnect)
            GestureDetector(
                onTap: widget.onChatPressed,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.black.withOpacity(0.6),
                  ),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ))
        ],
      );

  void _onSharePressed() async {
    final shareLink = await _getShareLink();
    _openShareProfile(shareLink);
  }

  _openShareProfile(String link) async {
    await FlutterShare.share(
        title: kMaterialAppTitle,
        text: StringConst.letsConnectOnDHText,
        linkUrl: link,
        chooserTitle: kMaterialAppTitle);
  }

  Future<String> _getShareLink() async {
    if (widget.candidate.user == null) {
      return '';
    }
    return (await ShortLink.createCandidateProfileShortLink(
            widget.candidate.user!.id.toString(), kCandidateShortLink))
        .toString();
  }

  Widget get _getRating => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        decoration: const BoxDecoration(
            color: AppColors.backgroundGrey,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  StringConst.candidateRatingText,
                  style: TextStyle(
                    color: AppColors.greyShade2,
                    fontSize: 15,
                  ),
                ),
                GestureDetector(
                    onTap: () => Get.toNamed(reviewsPageRoute, parameters: {
                          DBUtils.employerTableName:
                              json.encode(widget.candidate).toString()
                        }),
                    child: Container(
                      height: 30, width: 70,
                      // color: Colors.black,
                      alignment: Alignment.centerRight,
                      child: const Text(
                        StringConst.seeAllText,
                        style: TextStyle(
                            color: AppColors.greyShade2,
                            fontSize: 12,
                            decoration: TextDecoration.underline),
                      ),
                    )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            RatingItem(candidate: widget.candidate)
          ],
        ),
      );

  Widget _buildImages() {
    return ImageSlider(media: widget.candidate.media);
  }

  Widget _buildContentText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.candidate.selfDesc ?? '',
          style: const TextStyle(
              fontSize: 15, color: AppColors.primaryGrey, height: 2),
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          widget.candidate.expectEmployer ?? '',
          style: const TextStyle(
              fontSize: 15, color: AppColors.primaryGrey, height: 2),
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }

  Widget buildItemInformation(String? title, List<String?> itemInformation) {
    return SizedBox(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title ?? '',
              style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.white,
                  fontWeight: FontWeight.w600),
            ),
            // const Icon(
            //   Iconsax.magicpen,
            //   color: AppColors.primaryColor,
            // )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        ListView.builder(
            itemCount: itemInformation.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, index) {
              return itemInformation[index] != ''
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        '\u2022 ${itemInformation[index]!}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryGrey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  : const SizedBox.shrink();
            })
      ]),
    );
  }

  Widget buildHeaderWorkingExperience() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          StringConst.workingExperienceText,
          style: TextStyle(
              fontSize: 15,
              color: AppColors.white,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  //Working Experience
  Widget get _getWorkExperienceListView => widget.candidate.employments != null
      ? ListView.builder(
          itemCount: widget.candidate.employments!.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return EmploymentItem(
              employment: widget.candidate.employments![index],
            );
          })
      : const SizedBox.shrink();

  List<String?> _getWorkingPreferences() {
    return [
      "${widget.candidate.restDayChoice ?? 0} Rest days per month ${widget.candidate.restDayWorkPref != null && widget.candidate.restDayWorkPref! ? '(Work on rest days)' : '(*Not willing to work on rest days)'}",
      'Preferred Task: ${_getPreferedTasks()}',
      'Additional Working Preferences:${widget.candidate.workReligionPref ?? ''}',
      'Food & Drug Allergy:${widget.candidate.foodDrugAllergy ?? ''}',
    ];
  }

  _getPreferedTasks() {
    if (widget.candidate.tasksTypes != null &&
        widget.candidate.tasksTypes!.isNotEmpty) {
      String tasksList = '';
      for (int i = 0; i < widget.candidate.tasksTypes!.length; i++) {
        if (i != widget.candidate.tasksTypes!.length - 1) {
          tasksList += '${widget.candidate.tasksTypes![i].taskType}, ';
        } else {
          tasksList += '${widget.candidate.tasksTypes![i].taskType}';
        }
      }
      return tasksList;
    } else {
      return '';
    }
  }

  _addLanguages() {
    if (widget.candidate.languageProficientEnglish != null &&
        widget.candidate.languageProficientEnglish!) {
      languageList.add('Proficient English');
    }
    if (widget.candidate.languageChineseMandarin != null &&
        widget.candidate.languageChineseMandarin!) {
      languageList.add('Chinese Mandarin');
    }
    if (widget.candidate.languageBahasaMelayu != null &&
        widget.candidate.languageBahasaMelayu!) {
      languageList.add('Bahasa Melayu');
    }
    if (widget.candidate.languageTamil != null &&
        widget.candidate.languageTamil!) {
      languageList.add('Tamil');
    }
    if (widget.candidate.languageHokkien != null &&
        widget.candidate.languageHokkien!) {
      languageList.add('Hokkien');
    }
    if (widget.candidate.languageTeochew != null &&
        widget.candidate.languageTeochew!) {
      languageList.add('Tecochew');
    }
    if (widget.candidate.languageCantonese != null &&
        widget.candidate.languageCantonese!) {
      languageList.add('Cantonese');
    }
    if (widget.candidate.languageBahasaIndonesian != null &&
        widget.candidate.languageBahasaIndonesian!) {
      languageList.add('Bahasa Indonesian');
    }
    if (widget.candidate.languageJapanese != null &&
        widget.candidate.languageJapanese!) {
      languageList.add('Japanese');
    }
    if (widget.candidate.languageKorean != null &&
        widget.candidate.languageKorean!) {
      languageList.add('Korean');
    }
    if (widget.candidate.languageFrench != null &&
        widget.candidate.languageFrench!) {
      languageList.add('French');
    }
    if (widget.candidate.languageGerman != null &&
        widget.candidate.languageGerman!) {
      languageList.add('German');
    }
    languageList.add(widget.candidate.languageOthersSpecify ?? '');
  }

  _addSkills() {
    if (widget.candidate.skillGeneralHousework != null &&
        widget.candidate.skillGeneralHousework!) {
      skillList.add('General Housework');
    }
    if (widget.candidate.skillInfantCare != null &&
        widget.candidate.skillInfantCare!) {
      skillList.add('Infant Care');
    }
    if (widget.candidate.skillElderlyCare != null &&
        widget.candidate.skillElderlyCare!) {
      skillList.add('Elderly Care');
    }
    if (widget.candidate.skillPetCare != null &&
        widget.candidate.skillPetCare!) {
      skillList.add('Pet Care');
    }
    if (widget.candidate.skillCooking != null &&
        widget.candidate.skillCooking!) {
      skillList.add('Cooking');
    }
    if (widget.candidate.skillSpecialNeedsCare != null &&
        widget.candidate.skillSpecialNeedsCare!) {
      skillList.add('Special Needs Care');
    }
    if (widget.candidate.skillbedriddenCare != null &&
        widget.candidate.skillbedriddenCare!) {
      skillList.add('Bedidden Care');
    }
    if (widget.candidate.skillHandicapCare != null &&
        widget.candidate.skillHandicapCare!) {
      skillList.add('Handicap Care');
    }
  }

  _getFamilyInformation() {
    return widget.candidate.familyStatus ?? '';
  }

  _getSiblingInfo() {
    return widget.candidate.numOfSiblings != null &&
            widget.candidate.numOfSiblings != 0
        ? '${widget.candidate.numOfSiblings} Siblings'
        : '';
  }

  _getFamilyMembers() {
    if (widget.candidate.familyMembers != null &&
        widget.candidate.familyMembers!.isNotEmpty) {
      String familyMembers = '';
      for (int i = 0; i < widget.candidate.familyMembers!.length; i++) {
        familyMembers +=
            '${widget.candidate.familyMembers![i]['member_type']} (${getAgeFromYear(widget.candidate.familyMembers![i]['pivot']['member_dob_year'])} years)';
        if (i != widget.candidate.familyMembers!.length - 1) {
          familyMembers += ', ';
        }
      }
      return familyMembers;
    } else {
      return '';
    }
  }

  int getAgeFromYear(int? year) {
    if (year == null) return 0;
    final nowYear = DateTime.now().year;
    return nowYear - year;
  }

  _getAvalibilityStatus() {
    return widget.candidate.availabilityStatus != null &&
            widget.candidate.availabilityStatus == 'Not Looking For Job'
        ? Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            width: MediaQuery.of(context).size.width - 40,
            height: 30,
            decoration: BoxDecoration(
                color: const Color(0xff252525).withOpacity(0.6),
                borderRadius: BorderRadius.circular(15.0)),
            child: const Center(
                child: Text(
              'This offer is currently unavailable',
              style: TextStyle(color: AppColors.primaryGrey),
            )),
          )
        : Container();
  }

  //Work Permit
  Widget buildWorkPermitValidity() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(StringConst.workPermitValidityText,
              style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.white,
                  fontWeight: FontWeight.w600)),
          const SizedBox(
            height: 10,
          ),
          Table(
            columnWidths: const {0: FixedColumnWidth(150)},
            children: [
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    '${StringConst.statusText}  -',
                    style:
                        const TextStyle(color: AppColors.white, fontSize: 14),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                          color: getWorkPermitColor(),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        workPermitStatus != 'Pending'
                            ? workPermitStatus.tr
                            : 'Pending 48 Hrs Verification'.tr,
                        style: const TextStyle(
                            color: AppColors.white, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    '${StringConst.expiryText}  -',
                    style:
                        const TextStyle(color: AppColors.white, fontSize: 14),
                  ),
                ),
                workPermitStatus == 'Verified'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          widget.candidate.workPermit != null
                              ? DateFormat('dd MMM, yyyy').format(
                                  DateTime.parse(
                                      widget.candidate.workPermit!.expiryDate!))
                              : 'Invalid',
                          style: const TextStyle(
                              color: AppColors.white, fontSize: 14),
                        ),
                      )
                    : const SizedBox.shrink(),
              ]),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      );

  getWorkPermitColor() {
    switch (workPermitStatus.toLowerCase()) {
      case 'pending':
        return AppColors.primaryColor;
      case 'verified':
        return AppColors.green;
      default:
        return AppColors.red;
    }
  }
}
