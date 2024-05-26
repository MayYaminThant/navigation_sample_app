part of '../../views.dart';

class ResetPasswordSection extends StatefulWidget {
  const ResetPasswordSection({super.key});

  @override
  State<ResetPasswordSection> createState() => _ResetPasswordSectionState();
}

class _ResetPasswordSectionState extends State<ResetPasswordSection> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  String requestId = '';
  String method = '';
  String email = '';
  int countryCallingCode = 0;
  int phoneNumber = 0;

  @override
  void initState() {
    initializeData();
    super.initState();
  }

  initializeData() {
    if (Get.parameters.isNotEmpty) {
      requestId = Get.parameters['request_id'] ?? '';
      method = Get.parameters['method'] ?? '';
      email = Get.parameters['email'] ?? '';
      countryCallingCode = Get.parameters['countryCallingCode'] != '' &&
              Get.parameters['countryCallingCode'] != null
          ? int.parse(Get.parameters['countryCallingCode'].toString())
          : 0;
      phoneNumber = Get.parameters['phoneNumber'] != '' &&
              Get.parameters['phoneNumber'] != null
          ? int.parse(Get.parameters['phoneNumber'].toString())
          : 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployerBloc, EmployerState>(builder: (_, state) {
      return _getForgotPasswordScaffold;
    }, listener: (_, state) {
      if (state is EmployerResetPasswordSuccess) {
        if (state.data.data != null) {
          showSuccessSnackBar(state.data.data!['message']);
          Get.offNamed(recoverSuccessPageRoute);
        }
      }

      if (state is EmployerResetPasswordFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  Widget get _getForgotPasswordScaffold {
    return WillPopScope(
        onWillPop: () async {
          Get.toNamed(signInPageRoute);
          return false;
        },
        child: Scaffold(
          body: SingleChildScrollView(child: _getForgotPasswordContainer),
        ));
  }

  //Stack with background image
  Widget get _getForgotPasswordContainer {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/no-image-bg.png'),
              fit: BoxFit.cover)),
      child: _getForgotPasswordColumn,
    );
  }

  Widget get _getForgotPasswordColumn {
    return Column(
      children: [
        const SizedBox(
          height: 60,
        ),
        _getForgotPasswordHeader,
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: HeroImage(imagePath: 'assets/images/reset_password.png')),
        const Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text(
              StringConst.enterNewPasswordText,
              style: TextStyle(color: AppColors.primaryGrey, fontSize: 15.0),
            )),
        getTextField(newPasswordController, StringConst.newPasswordText, true),
        getTextField(confirmNewPasswordController,
            StringConst.confirmNewPasswordText, true),
        Expanded(child: Container()),
        _getConfirmNewPassword
      ],
    );
  }

  Widget get _getForgotPasswordHeader {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => Get.toNamed(signInPageRoute),
          child: const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Icon(
              Iconsax.arrow_left,
              color: AppColors.white,
            ),
          ),
        ),
        const Text(
          StringConst.resetPasswordText,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppColors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 40,
        )
      ],
    );
  }

  getTextField(
      TextEditingController controller, String title, bool hasSuffixIcon) {
    return CustomTextField(
      backgroundColor: AppColors.primaryGrey.withOpacity(0.1),
      controller: controller,
      textInputType: TextInputType.text,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
      hasPrefixIcon: false,
      hasTitle: true,
      obscured: hasSuffixIcon,
      hasSuffixIcon: hasSuffixIcon,
      isRequired: true,
      textFormFieldMargin:
          const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
      titleStyle: const TextStyle(
        color: AppColors.white,
        fontSize: Sizes.textSize14,
      ),
      hasTitleIcon: false,
      enabledBorder: Borders.noBorder,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.white),
      ),
      hintTextStyle: const TextStyle(
        color: AppColors.primaryGrey,
        fontSize: Sizes.textSize12,
      ),
      textStyle: const TextStyle(color: AppColors.primaryGrey),
      hintText: title,
    );
  }

  Widget get _getConfirmNewPassword {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30.0, left: 20.0, right: 20.0),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          CustomPrimaryButton(
            text: StringConst.submitText,
            onPressed: () => _checkValidation(),
          )
        ]),
      ),
    );
  }

  //Validation
  _checkValidation() {
    if (newPasswordController.text.isEmpty) {
      showErrorSnackBar('Please enter your new password.');
    } else if (confirmNewPasswordController.text.isEmpty) {
      showErrorSnackBar('Please confirm your password.');
    } else if (newPasswordController.text !=
        confirmNewPasswordController.text) {
      showErrorSnackBar('Your password is not matched.');
    } else if (newPasswordController.text ==
        confirmNewPasswordController.text) {
      _requestResetPassword();
    }
  }

  //request reset password
  void _requestResetPassword() {
    final employerBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerResetPasswordRequestParams params =
        EmployerResetPasswordRequestParams(
            path: method,
            countryCallingCode: method == 'phone' ? countryCallingCode : null,
            phoneNumber: method == 'phone' ? phoneNumber : null,
            email: method == 'email' ? email : null,
            password: newPasswordController.text.toString(),
            passwordConfirmation: confirmNewPasswordController.text.toString(),
            requestId: requestId);
    Map data = {
      'path': method,
      'countryCallingCode': method == 'phone' ? countryCallingCode : null,
      'phoneNumber': method == 'phone' ? phoneNumber : null,
      'email': method == 'email' ? email : null,
      'password': newPasswordController.text.toString(),
      'passwordConfirmation': confirmNewPasswordController.text.toString(),
      'requestId': requestId
    };
    print('data $data');
    employerBloc.add(EmployerResetPasswordRequested(params: params));
  }
}
