import 'package:dh_mobile/src/presentations/values/values.dart';
import 'package:dh_mobile/src/presentations/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/params/params.dart';
import '../../../../core/utils/configs_key_helper.dart';
import '../../../../core/utils/constants.dart';
import '../../../../domain/entities/entities.dart';
import '../../../blocs/blocs.dart';
import '../../../widgets/custom_date_picker.dart';

class EmploymentHistoryUpdateModal extends StatefulWidget {
  final Function(String)? onSave;
  final String? token;
  final int? userId;
  final Employment employment;

  const EmploymentHistoryUpdateModal(
      {super.key,
      this.onSave,
      this.token,
      required this.employment,
      this.userId});

  @override
  State<EmploymentHistoryUpdateModal> createState() =>
      _EmploymentHistoryUpdateModalState();
}

class _EmploymentHistoryUpdateModalState
    extends State<EmploymentHistoryUpdateModal> {
  final TextEditingController workDescriptionController =
      TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  String country = '';
  bool dhRelated = true;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  void initializeData() {
    country = widget.employment.countryName ?? '';
    workDescriptionController.text = widget.employment.desc ?? '';
    dhRelated = widget.employment.dhRelated != null
        ? widget.employment.dhRelated!
        : true;
    startDateController.text = widget.employment.startDate ?? '';
    endDateController.text = widget.employment.endDate ?? '';
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
        decoration: BoxDecoration(
          color: AppColors.greyBg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 18,
                ),
                Text(
                  StringConst.employmentHistoryTitle,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyShade2),
                ),
                const SizedBox(height: 20),
                CountryDropdownItem(
                  backgroundColor: AppColors.white,
                  topCountries: kEmployerTopCountries,
                  textColor: Colors.black,
                  title: 'Select',
                  onValueChanged: (String data) {
                    setState(() {
                      country = data;
                    });
                  },
                  prefix: ConfigsKeyHelper.employmentKey,
                  initialValue: country,
                ),
                const SizedBox(height: 20),
                _getDateItem,
                const SizedBox(height: 10),
                _getTextField(
                    workDescriptionController,
                    "${'Enter Your Work Description'.tr}\n${'*Please make it brief for words limit'.tr}",
                    false,
                    4,
                    AppColors.white),
                const SizedBox(height: 10),
                _getDHRelated,
                const SizedBox(height: 20),
                CustomPrimaryButton(
                  text: StringConst.addEmploymentText,
                  fontSize: 16,
                  widthButton: MediaQuery.of(context).size.width,
                  onPressed: () => _updateCandidateEmployment(),
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
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(StringConst.dhWorkExperienceText),
          )
        ],
      );

  //Update Candidate Employment
  void _updateCandidateEmployment() {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateUpdateEmploymentRequestParams params =
        CandidateUpdateEmploymentRequestParams(
            token: widget.token,
            userId: widget.userId,
            employmentID: widget.employment.id,
            workCountryName: country,
            workDesc: workDescriptionController.text,
            startDate: startDateController.text,
            endDate: endDateController.text,
            dhRelated: dhRelated ? 1 : 0);
    candidateBloc.add(CandidateUpdateEmlpoymentRequested(params: params));
  }
}
