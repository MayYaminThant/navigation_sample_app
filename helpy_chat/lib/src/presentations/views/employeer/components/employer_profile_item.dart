import 'dart:convert';

import 'package:dh_mobile/src/config/routes/routes.dart';
import 'package:dh_mobile/src/core/utils/db_utils.dart';
import 'package:dh_mobile/src/core/utils/shortlink.dart';
import 'package:dh_mobile/src/presentations/views/employeer/components/employer_profile_actions.dart';
import 'package:dh_mobile/src/presentations/views/employeer/components/rating_item.dart';
import 'package:dh_mobile/src/presentations/widgets/image_slider.dart';
import 'package:dh_mobile/src/presentations/widgets/super_print.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/loading.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../domain/entities/entities.dart';
import '../../../blocs/blocs.dart' as k_connection_bloc;
import '../../../values/values.dart';
import 'employeer_info.dart';
import 'jobs_info.dart';

class EmployeerProfileItem extends StatefulWidget {
  const EmployeerProfileItem(
      {super.key,
      required this.employer,
      this.onChatPressed,
      this.onStarPressed,
      required this.isStarList,
      this.isBottomBar});

  final Employer employer;
  final VoidCallback? onChatPressed;
  final VoidCallback? onStarPressed;
  final bool isStarList;
  final bool? isBottomBar;

  @override
  State<EmployeerProfileItem> createState() => _EmployeerProfileItemState();
}

class _EmployeerProfileItemState extends State<EmployeerProfileItem> {
  List<String> languageSkillList = [];

  @override
  void initState() {
    super.initState();
    _addLanguages();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<k_connection_bloc.ConnectionBloc,
        k_connection_bloc.ConnectionState>(builder: (_, state) {
      return _getEmployeeProfileContainer;
    }, listener: (_, state) {
      if (state is k_connection_bloc.ConnectionSendRequestLoading) {
        Loading.showLoading(message: StringConst.loadingText);
      }
      if (state is k_connection_bloc.ConnectionSendRequestSuccess) {
        Loading.cancelLoading();
        if (state.connectionData.data != null) {
          showSuccessSnackBar(state.connectionData.data!['message']);
        }
      }
      if (state is k_connection_bloc.ConnectionSendRequestFail) {
        Loading.cancelLoading();
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  //Employer Profile
  Stack get _getEmployeeProfileContainer => Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: widget.isBottomBar != null && widget.isBottomBar!
                ? MediaQuery.of(context).size.height - 220
                : MediaQuery.of(context).size.height - 180,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView(
              children: [
                _getAvalibilityStatus,
                EmployerInfo(
                  employer: widget.employer,
                  isStarList: widget.isStarList,
                ),
                const SizedBox(
                  height: 20,
                ),
                JobsInfo(
                  employer: widget.employer,
                  fontSize: 15,
                  paddingSize: 10,
                ),
                const SizedBox(
                  height: 20,
                ),
                EmployerProfileActions(
                    employer: widget.employer,
                    onChatPressed: widget.onChatPressed,
                    onStarPressed: widget.onStarPressed,
                    onSharePressed: _onSharePressed,
                    isStarList: widget.isStarList),
                const SizedBox(
                  height: 25,
                ),
                ImageSlider(media: widget.employer.media),
                const SizedBox(
                  height: 15,
                ),
                _buildContentText(),
                buildItemInformation('Language Skills', languageSkillList),
                const SizedBox(
                  height: 20,
                ),
                buildItemInformation('Special Request', [
                  widget.employer.specialRequestChildern,
                  widget.employer.specialRequestElderly,
                  widget.employer.specialRequestPet
                ]),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
          Positioned(bottom: 10, right: 20, left: 20, child: _getRating)
        ],
      );

  Widget _buildContentText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.employer.selfDesc ?? '',
          style: const TextStyle(
              fontSize: 15, color: AppColors.primaryGrey, height: 2),
        ),
        if (widget.employer.selfDesc != null && widget.employer.selfDesc != '') const SizedBox(
          height: 24,
        ),
        Text(
          widget.employer.expectCandidate ?? '',
          style: const TextStyle(
              fontSize: 15, color: AppColors.primaryGrey, height: 2),
        ),
        if (widget.employer.expectCandidate != null && widget.employer.expectCandidate != '') const SizedBox(
          height: 24,
        ),
      ],
    );
  }

  void _onSharePressed() async {
    final shareLink = await _getShareLink();
    _openShareProfile(shareLink);
  }

  _openShareProfile(String link) async {
    superPrint(link);
    await FlutterShare.share(
        title: kMaterialAppTitle,
        text: StringConst.letsConnectOnDHText,
        linkUrl: link,
        chooserTitle: kMaterialAppTitle);
  }

  Future<String> _getShareLink() async {
    if (widget.employer.user == null) {
      return '';
    }
    return (await ShortLink.createEmployerProfileShortLink(
            widget.employer.user!.id.toString(), kEmployerShortLink))
        .toString();
  }

  //Rating
  Widget get _getRating => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  StringConst.employerRatingText.tr,
                  style: const TextStyle(
                    color: AppColors.blackShade2,
                    fontSize: 16,
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(reviewsPageRoute, parameters: {
                    DBUtils.candidateTableName:
                        json.encode(widget.employer).toString()
                  }),
                  child: Text(
                    StringConst.seeAllText.tr,
                    style: const TextStyle(
                        color: AppColors.blackShade2,
                        fontSize: 12,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            RatingItem(employer: widget.employer)
          ],
        ),
      );

  Widget buildItemInformation(String? title, List<String?> itemInformation) {
    if (itemInformation.isEmpty ||
        !itemInformation.any((item) => (item != null && item != ''))) {
      return Container();
    }

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
                  ? Text(
                      '\u2022 ${itemInformation[index]!}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.primaryGrey,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : const SizedBox.shrink();
            })
      ]),
    );
  }

  void _addLanguages() {
    if (widget.employer.languageProficientEnglish != null &&
        widget.employer.languageProficientEnglish!) {
      languageSkillList.add('Proficient English');
    }
    if (widget.employer.languageChineseMandarin != null &&
        widget.employer.languageChineseMandarin!) {
      languageSkillList.add('Chinese Mandarin');
    }
    if (widget.employer.languageBahasaMelayu != null &&
        widget.employer.languageBahasaMelayu!) {
      languageSkillList.add('Bahasa Melayu');
    }
    if (widget.employer.languageTamil != null &&
        widget.employer.languageTamil!) {
      languageSkillList.add('Tamil');
    }
    if (widget.employer.languageHokkien != null &&
        widget.employer.languageHokkien!) {
      languageSkillList.add('Hokkien');
    }
    if (widget.employer.languageTeochew != null &&
        widget.employer.languageTeochew!) {
      languageSkillList.add('Tecochew');
    }
    if (widget.employer.languageCantonese != null &&
        widget.employer.languageCantonese!) {
      languageSkillList.add('Cantonese');
    }
    if (widget.employer.languageBahasaIndonesian != null &&
        widget.employer.languageBahasaIndonesian!) {
      languageSkillList.add('Bahasa Indonesian');
    }
    if (widget.employer.languageJapanese != null &&
        widget.employer.languageJapanese!) {
      languageSkillList.add('Japanese');
    }
    if (widget.employer.languageKorean != null &&
        widget.employer.languageKorean!) {
      languageSkillList.add('Korean');
    }
    if (widget.employer.languageFrench != null &&
        widget.employer.languageFrench!) {
      languageSkillList.add('French');
    }
    if (widget.employer.languageGerman != null &&
        widget.employer.languageGerman!) {
      languageSkillList.add('German');
    }
    if (widget.employer.languageArabic != null &&
        widget.employer.languageArabic!) {
      languageSkillList.add('Arabic');
    }

    if (widget.employer.languageOthersSpecify != null) {
      languageSkillList.add(widget.employer.languageOthersSpecify!);
    }
  }

  Widget get _getAvalibilityStatus => widget.employer.availabilityStatus != null
      ? Container(
          margin: const EdgeInsets.only(bottom: 20.0),
          width: MediaQuery.of(context).size.width - 40,
          height: 30,
          decoration: BoxDecoration(
              color: const Color(0xff252525).withOpacity(0.6),
              borderRadius: BorderRadius.circular(15.0)),
          child: Center(
              child: Text(
            widget.employer.availabilityStatus ?? '',
            style: const TextStyle(color: AppColors.primaryGrey),
          )),
        )
      : Container();
}
