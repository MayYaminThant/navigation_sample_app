part of '../../views.dart';

class DeclarationModal extends StatefulWidget {
  const DeclarationModal({super.key});

  @override
  State<DeclarationModal> createState() => _DeclarationModalState();
}

class _DeclarationModalState extends State<DeclarationModal> {
  List<String> declarationTextList = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: StatefulBuilder(
            builder: (context, setState) => _getDeclarationContainer(setState),
          ),
        ));
  }

  Widget _getDeclarationContainer(setState) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            StringConst.termsAndConditionTitle.tr,
            style: const TextStyle(color: AppColors.black, fontSize: 16),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            StringConst.declarationSubTitle.tr,
            style: const TextStyle(color: AppColors.primaryGrey, fontSize: 12),
          ),
          const SizedBox(
            height: 10,
          ),
          _getDeclarationCheckBox(StringConst.declarationText1.tr, setState),
          const SizedBox(
            height: 20,
          ),
          _getDeclarationCheckBox(StringConst.declarationText3.tr, setState),
          const SizedBox(
            height: 20,
          ),
          _getTermsAndEULA(setState),
          const SizedBox(
            height: 20,
          ),
          CustomPrimaryButton(
            text: StringConst.agreeText.tr,
            fontSize: 14,
            heightButton: 47,
            widthButton: MediaQuery.of(context).size.width,
            onPressed: declarationTextList.length == 3
                ? () => _checkValidation()
                : null,
          ),
        ],
      );

  //Declaration CheckBoxs
  Widget _getDeclarationCheckBox(String title, setState) => CustomCheckBox(
      crossAxisAlignment: CrossAxisAlignment.start,
      checkBoxColor: AppColors.primaryGrey.withOpacity(0.8),
      onValueChanged: (bool value) {
        if (value && !declarationTextList.contains(title)) {
          setState(() {
            declarationTextList.add(title);
          });
        }
        if (!value && declarationTextList.contains(title)) {
          setState(() {
            declarationTextList.remove(title);
          });
        }
      },
      trailing: SizedBox(
        width: MediaQuery.of(context).size.width * 0.55,
        child: Text(title,
            textAlign: TextAlign.justify,
            softWrap: true,
            style: TextStyle(
                color: AppColors.black.withOpacity(0.3), fontSize: 12)),
      ));

  Widget _getTermsAndEULA(setState) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomCheckBox(
            crossAxisAlignment: CrossAxisAlignment.start,
            checkBoxColor: AppColors.primaryGrey.withOpacity(0.8),
            onValueChanged: (bool value) {
              if (value && !declarationTextList.contains('EULA')) {
                setState(() {
                  declarationTextList.add('EULA');
                });
              }
              if (!value && declarationTextList.contains('EULA')) {
                setState(() {
                  declarationTextList.remove('EULA');
                });
              }
            },
            trailing: _getTermsOfService,
          ),
        ],
      );

  Widget get _getTermsOfService => SizedBox(
        width: MediaQuery.of(context).size.width * 0.55,
        child: Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text: 'By Signing up, you agree to our ',
                style: TextStyle(color: AppColors.primaryGrey, fontSize: 12),
              ),
              TextSpan(
                  text: StringConst.termsAndConditionTitle.tr,
                  style: const TextStyle(
                      color: AppColors.secondaryColor, fontSize: 12),
                  recognizer: TapGestureRecognizer()
                    ..onTap =
                        () => Get.toNamed(termsAndPolicyRoute, arguments: 1)),
              const TextSpan(
                text: ' that you have read our ',
                style: TextStyle(color: AppColors.primaryGrey, fontSize: 12),
              ),
              TextSpan(
                  text: 'Privacy Policy',
                  style: const TextStyle(
                      color: AppColors.secondaryColor, fontSize: 12),
                  recognizer: TapGestureRecognizer()
                    ..onTap =
                        () => Get.toNamed(termsAndPolicyRoute, arguments: 2)),
              const TextSpan(
                text: ' and ',
                style: TextStyle(color: AppColors.primaryGrey, fontSize: 12),
              ),
              TextSpan(
                  text: 'EULA',
                  style: const TextStyle(
                      color: AppColors.secondaryColor, fontSize: 12),
                  recognizer: TapGestureRecognizer()
                    ..onTap =
                        () => Get.toNamed(termsAndPolicyRoute, arguments: 3)),
              const TextSpan(
                text: '.',
                style: TextStyle(color: AppColors.primaryGrey, fontSize: 12),
              ),
            ],
          ),
          softWrap: true,
          textAlign: TextAlign.justify,
        ),
      );

  void _checkValidation() => declarationTextList.length == 3
      ? Navigator.of(context, rootNavigator: true).pop()
      : null;
}
