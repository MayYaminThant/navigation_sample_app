import 'package:dh_mobile/src/config/routes/routes.dart';
import 'package:dh_mobile/src/core/params/params.dart';
import 'package:dh_mobile/src/core/utils/db_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../blocs/blocs.dart';
import '../../../values/values.dart';
import '../../../widgets/widgets.dart';

class ComplaintViolationModal extends StatefulWidget {
  const ComplaintViolationModal(
      {super.key,
      required this.token,
      required this.userId,
      required this.controller,
      required this.conversationId});

  final String token;
  final int userId;
  final ScrollController controller;
  final String conversationId;

  @override
  State<ComplaintViolationModal> createState() =>
      _ComplaintViolationModalState();
}

class _ComplaintViolationModalState extends State<ComplaintViolationModal> {
  List<String> declarationTextList = [];
  final TextEditingController othersComplainController =
      TextEditingController();
  String clickedData = '';

  @override
  Widget build(BuildContext context) {
    return _getComplaint;
  }

  WillPopScope get _getComplaint => WillPopScope(
      onWillPop: () async => false, child: _getDeclarationContainer);

  Widget get _getDeclarationContainer => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        controller: widget.controller,
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? 350 : 0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  StringConst.complaintViolationTitle.tr,
                  style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Divider(),
              ),
              Text(
                StringConst.complaintViolationSubTitle.tr,
                style: const TextStyle(color: AppColors.black, fontSize: 12),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                StringConst.complaintViolationDesc.tr,
                style: const TextStyle(
                    height: 1.3, color: AppColors.primaryGrey, fontSize: 12),
              ),
              const SizedBox(
                height: 15,
              ),
              getComplaintTitles(StringConst.nudityText),
              const SizedBox(
                height: 15,
              ),
              getComplaintTitles(
                StringConst.violenceText,
              ),
              const SizedBox(
                height: 15,
              ),
              getComplaintTitles(StringConst.harassmentText),
              const SizedBox(
                height: 15,
              ),
              getComplaintTitles(StringConst.falseInformationText),
              const SizedBox(
                height: 15,
              ),
              getComplaintTitles(StringConst.spamText),
              const SizedBox(
                height: 15,
              ),
              getComplaintTitles(StringConst.hateSpeechText),
              const SizedBox(
                height: 15,
              ),
              getComplaintTitles(StringConst.terrorismText),
              const SizedBox(
                height: 15,
              ),
              getOtherSpecifyTitle,
              const SizedBox(
                height: 15,
              ),
              if (clickedData == StringConst.othersViolationText)
                _getOtherSpecify,
              const SizedBox(
                height: 15,
              ),
              CustomPrimaryButton(
                text: StringConst.submitText,
                fontSize: 16,
                widthButton: MediaQuery.of(context).size.width,
                customColor: clickedData != ''
                    ? AppColors.primaryColor
                    : AppColors.primaryGrey,
                onPressed: clickedData != '' ? () => _checkValidation() : null,
              ),
            ],
          ),
        ),
      );

  Widget getComplaintTitles(String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          clickedData = title;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title.tr,
              style: TextStyle(
                  color: AppColors.black.withOpacity(0.5),
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            if (clickedData == title)
              SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset('assets/icons/check.png'))
          ],
        ),
      ),
    );
  }

  Widget get getOtherSpecifyTitle => GestureDetector(
        onTap: () => setState(() {
          clickedData = StringConst.othersViolationText;
        }),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                StringConst.othersViolationText.tr,
                style: TextStyle(
                    color: AppColors.black.withOpacity(0.5),
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: AppColors.black.withOpacity(0.5),
              )
            ],
          ),
        ),
      );

  Widget get _getOtherSpecify {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Please specify in details.'.tr,
          style: TextStyle(
            color: AppColors.black.withOpacity(0.5),
            fontSize: 12,
          ),
        ),
        Text(
          'Let us know how we can help you and the community.'.tr,
          style: TextStyle(
            color: AppColors.primaryGrey.withOpacity(0.5),
            fontSize: 12,
          ),
        ),
        _getTextField(othersComplainController, 'Write Here', false, 3,
            AppColors.primaryGrey.withOpacity(0.1)),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _getTextField(TextEditingController controller, String title,
      bool hasSuffixIcon, int? maxLine, Color? backgroundColor) {
    return CustomTextField(
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
      maxLength: 256,
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
    );
  }

  Future<void> _createComplaint() async {
    ZIMKit().deleteConversation(widget.conversationId, ZIMConversationType.peer,
        isAlsoDeleteMessages: true);

    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateProfileComplaintRequestParams params =
        CandidateProfileComplaintRequestParams(
            token: widget.token, userId: widget.userId);
    candidateBloc.add(CandidateProfileComplaintRequested(params: params));

    await _cacheComplaint(widget.userId.toString());

    _requestConnectionsList();
    Get.until((route) => route.settings.name == chatListPageRoute);
  }

  Future<void> _cacheComplaint(String userId) async {
    Box box = await Hive.openBox(DBUtils.dbName);
    List<String> currentComplaints = box.get('chat_complaints') ?? [];
    currentComplaints.add(userId);
    box.put('chat_complaints', currentComplaints);
  }

  void _requestConnectionsList() {
    final connectionBloc = BlocProvider.of<ConnectionBloc>(context);
    ConnectionListRequestParams params = ConnectionListRequestParams(
      token: widget.token,
    );
    connectionBloc.add(ConnectionListRequested(params: params));
  }

  void _checkValidation() {
    if (clickedData == StringConst.othersViolationText &&
        othersComplainController.text.isEmpty) {
      showErrorSnackBar('Please write a Specific Violation');
    } else {
      _createComplaint();
    }
  }
}
