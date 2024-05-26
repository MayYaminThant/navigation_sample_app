import 'package:dh_mobile/src/core/utils/configs_key_helper.dart';
import 'package:dh_mobile/src/presentations/values/values.dart';
import 'package:dh_mobile/src/presentations/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../../core/params/params.dart';
import '../../../../core/utils/constants.dart';
import '../../../blocs/blocs.dart';
import '../../../widgets/custom_date_picker.dart';

class EmploymentHistoryModal extends StatefulWidget {
  final Function(String)? onSave;
  final String? token;
  final int userId;
  final int displayOrder;

  const EmploymentHistoryModal(
      {super.key,
      this.onSave,
      this.token,
      required this.userId,
      required this.displayOrder});

  @override
  State<EmploymentHistoryModal> createState() => _EmploymentHistoryModalState();
}

class _EmploymentHistoryModalState extends State<EmploymentHistoryModal> {
  final TextEditingController workDescriptionController =
      TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  String country = '';
  bool dhRelated = false;
  bool isLoading = false;

  void changeLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 327,
        height: 455,
        decoration: BoxDecoration(
          color: AppColors.greyBg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(
                  height: 18,
                ),
                Text(
                  StringConst.employmentHistoryTitle.tr,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyShade2),
                ),
                const SizedBox(height: 20),
                CountryDropdownItem(
                    backgroundColor: AppColors.white,
                    textColor: Colors.black,
                    topCountries: kEmployerTopCountries,
                    title: 'Select',
                    onValueChanged: (String data) {
                      setState(() {
                        country = data;
                      });
                    },
                    prefix: ConfigsKeyHelper.employmentKey,
                    initialValue: ''),
                const SizedBox(height: 20),
                _getDateItem,
                const SizedBox(height: 10),
                _getTextField(
                    workDescriptionController,
                    "${'Enter Your Work Description'.tr}\n${'pleaseMakeWordsLimit'.tr}",
                    false,
                    4,
                    AppColors.white),
                const SizedBox(height: 10),
                _getDHRelated,
                const SizedBox(height: 20),
                BlocConsumer<CandidateBloc, CandidateState>(
                  builder: (context, state) => StatefulBuilder(
                    builder: (context, setState) => CustomPrimaryButton(
                      text: StringConst.addEmploymentText,
                      fontSize: 16,
                      widthButton: MediaQuery.of(context).size.width,
                      onPressed:
                          isLoading ? null : () => _createCandidateEmployment(),
                    ),
                  ),
                  listener: (context, state) {
                    if (state is CandidateCreateEmploymentLoading) {
                      changeLoading(true);
                    }
                    if (state is CandidateCreateEmploymentSuccess) {
                      changeLoading(false);
                    }
                    if (state is CandidateCreateEmploymentFail) {
                      changeLoading(false);
                    }
                  },
                )
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryGrey,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Transform.scale(
                      scale: 0.6,
                      child: Icon(
                        Icons.close,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _getDateItem => Table(
        children: [
          TableRow(children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: CustomDatePicker(
                controller: startDateController,
                enabled: true,
                backgroundColor: AppColors.white,
                isInitialDate: false,
                isShowPreviousDate: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: CustomDatePicker(
                controller: endDateController,
                enabled: true,
                backgroundColor: AppColors.white,
                isInitialDate: false,
                isShowPreviousDate: true,
              ),
            ),
          ])
        ],
      );

  Widget _getTextField(TextEditingController controller, String title,
      bool hasSuffixIcon, int? maxLine, Color? backgroundColor) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: CustomTextField(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: backgroundColor),
        maxLine: maxLine ?? 1,
        backgroundColor: AppColors.primaryGrey.withOpacity(0.1),
        controller: controller,
        textInputType: TextInputType.text,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
        hasPrefixIcon: false,
        hasTitle: true,
        isRequired: true,
        hasSuffixIcon: hasSuffixIcon,
        titleStyle: const TextStyle(
          color: AppColors.white,
          fontSize: Sizes.textSize14,
        ),
        hasTitleIcon: false,
        enabledBorder: Borders.noBorder,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1),
          borderSide: const BorderSide(color: AppColors.white),
        ),
        hintTextStyle:
            const TextStyle(color: AppColors.primaryGrey, fontSize: 14),
        textStyle: const TextStyle(color: AppColors.primaryGrey),
        hintText: title,
      ),
    );
  }

  Widget get _getDHRelated => Row(
        children: [
          CustomCheckBox(
            initialValue: dhRelated,
            onValueChanged: (bool value) {
              setState(() {
                dhRelated = value;
              });
            },
            trailing: Text(StringConst.dhWorkExperienceText.tr),
          ),
        ],
      );

  //Create Candidate Employment
  void _createCandidateEmployment() {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateCreateEmploymentRequestParams params =
        CandidateCreateEmploymentRequestParams(
            token: widget.token,
            userId: widget.userId,
            workCountryName: country,
            workDesc: workDescriptionController.text,
            startDate: startDateController.text,
            endDate: endDateController.text,
            dhRelated: dhRelated ? 1 : 0,
            displayOrder: widget.displayOrder);
    candidateBloc.add(CandidateCreateEmploymentRequested(params: params));
  }
}
