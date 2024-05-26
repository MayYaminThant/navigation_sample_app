part of '../../views.dart';

class ForgotPasswordSection extends StatefulWidget {
  const ForgotPasswordSection({super.key});

  @override
  State<ForgotPasswordSection> createState() => _ForgotPasswordSectionState();
}

class _ForgotPasswordSectionState extends State<ForgotPasswordSection> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final bool isEmail = Get.arguments == null ? true : Get.arguments.isEmail;
  Country? country;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployerBloc, EmployerState>(builder: (_, state) {
      return _getForgotPasswordScaffold;
    }, listener: (_, state) {
      if (state is EmployerForgotPasswordSuccess) {
        Loading.cancelLoading();
        if (state.data.data != null) {
          Get.toNamed(forgotOTPPageRoute, parameters: {
            'method': isEmail ? 'email' : 'phone',
            'requestId': state.data.data!['request_id'],
            'email': isEmail ? emailController.text.toString() : '',
            'countryCallingCode': !isEmail ? country!.dialCode ?? '' : '',
            'phoneNumber': !isEmail ? phoneController.text.toString() : '',
          });
        }
      }

      if (state is EmployerForgotPasswordFail) {
        Loading.cancelLoading();
        setState(() {
          isLoading = false;
        });
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  Widget get _getForgotPasswordScaffold {
    return Scaffold(
      body: _getForgotPasswordContainer,
    );
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
        child: SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: height),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 60.0),
                  child: _getForgotPasswordColumn,
                ))));
  }

  Widget get _getForgotPasswordColumn {
    return Column(
      children: [
        _getForgotPasswordHeader,
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0),
            child: HeroImage(imagePath: 'assets/images/forgot_password.png')),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            isEmail
                ? StringConst.forgotPasswordEmailText
                : StringConst.forgotPasswordPhoneText,
            style: const TextStyle(
                color: AppColors.primaryGrey, fontSize: 15, height: 2),
            textAlign: TextAlign.start,
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 25.0, bottom: 30.0),
            child: getUserField(isEmail)),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomPrimaryButton(
                    text: StringConst.submitText,
                    onPressed: isLoading ? null : () => _checkValidation(),
                  )
                ])),
      ],
    );
  }

  _checkValidation() {
    if (isLoading) {
      return;
    }
    if (isEmail) {
      if (emailController.text.isEmpty) {
        showErrorSnackBar('Email address is required.');
        return;
      }
    } else {
      if (country == null) {
        showErrorSnackBar('Country code is required.');
        return;
      }
      if (phoneController.text.isEmpty) {
        showErrorSnackBar('Phone number is required.');
        return;
      }
    }
    setState(() {
      isLoading = true;
    });
    Loading.showLoading(message: StringConst.loadingText);
    _requestValidation();
  }

  _requestValidation() {
    final employerBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerForgotPasswordRequestParams params =
        EmployerForgotPasswordRequestParams(
      path: isEmail ? 'email' : 'phone',
      email: isEmail ? emailController.text.toString() : null,
      countryCallingCode: !isEmail ? int.parse(country!.dialCode ?? '') : null,
      phoneNumber: !isEmail ? int.parse(phoneController.text) : null,
    );
    employerBloc.add(EmployerForgotPasswordRequested(params: params));
  }

  getUserField(bool isEmail) {
    if (isEmail) {
      return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(StringConst.enterEmailText,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: AppColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.normal))),
        getTextField(emailController, StringConst.emailAddressPlaceholder,
            prefixIconPath: Iconsax.sms)
      ]);
    }
    return _getPhoneNumber;
  }

  Widget get _getPhoneNumber => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const Text(StringConst.enterPhoneNumberText,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: AppColors.white,
                fontSize: 15,
                fontWeight: FontWeight.normal)),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 130,
                  child: PhoneNumberDropdownItem(
                      initialValue: '',
                      title: 'Country',
                      onValueChanged: (Country c) {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            country = c;
                          });
                        });
                      },
                      isCallCode: false,
                      prefix: ConfigsKeyHelper.forgetPhoneKey),
                ),
                Expanded(
                    child: getTextField(
                        phoneController, StringConst.phoneNumberOnlyText,
                        textInputType: const TextInputType.numberWithOptions(),
                        fieldPadding: const EdgeInsets.only(left: 10.0))),
              ],
            ))
      ]));

  //Forgot Password Title header
  Widget get _getForgotPasswordHeader {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: 25,
                child: InkWell(
                  onTap: () => Get.back(),
                  child: const Icon(
                    Iconsax.arrow_left,
                    color: AppColors.white,
                  ),
                )),
            const Text(
              StringConst.forgetPasswordText,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 25,
            )
          ],
        ));
  }

  //Forgot Password Textfield
  getTextField(TextEditingController controller, String title,
      {IconData? prefixIconPath,
      TextInputType? textInputType,
      EdgeInsetsGeometry? fieldPadding}) {
    return CustomTextField(
      prefixIcon: prefixIconPath == null
          ? null
          : Icon(prefixIconPath, color: AppColors.white),
      hasPrefixIcon: prefixIconPath != null,
      hasTitleIcon: false,
      backgroundColor: AppColors.primaryGrey.withOpacity(0.1),
      controller: controller,
      textInputType: textInputType ?? TextInputType.text,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
      hasTitle: true,
      isRequired: true,
      textFormFieldMargin: fieldPadding ??
          const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
      titleStyle: const TextStyle(
        color: AppColors.white,
        fontSize: Sizes.textSize14,
      ),
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
}

class ForgotPasswordSectionParams {
  bool isEmail;

  ForgotPasswordSectionParams({required this.isEmail});
}
