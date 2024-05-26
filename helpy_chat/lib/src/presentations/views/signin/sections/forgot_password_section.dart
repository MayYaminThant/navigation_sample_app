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
  String appLocale = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getAppLocaleName();
  }

  Future<void> _getAppLocaleName() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      appLocale = box.get(DBUtils.phoneCountry) ??
          box.get(DBUtils.country) ??
          'Singapore';
    });
  }

  void changeLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _getForgotPasswordScaffold;
  }

  Widget get _getForgotPasswordScaffold {
    return Scaffold(body: _getForgotPasswordContainer);
  }

  //Stack with background image
  Widget get _getForgotPasswordContainer {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/no-image-bg.png'),
                fit: BoxFit.cover)),
        child: _getForgotPasswordColumn,
      ),
    );
  }

  Widget get _getForgotPasswordColumn {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          height: 60,
        ),
        _getForgotPasswordHeader,
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 60.0),
            child: CustomImageView(image: 'assets/images/forgot_password.png')),
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
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: getUserField(isEmail)),
        Expanded(child: Container()),
        Padding(
            padding:
                const EdgeInsets.only(bottom: 30.0, left: 20.0, right: 20.0),
            child: BlocConsumer<CandidateBloc, CandidateState>(
                builder: (_, state) {
              return CustomPrimaryButton(
                text: StringConst.submitText,
                onPressed: isLoading ? null : () => _checkValidation(),
              );
            }, listener: (_, state) {
              if (state is CandidateForgotPasswordLoading) {
                changeLoading(true);
              }
              if (state is CandidateForgotPasswordSuccess) {
                changeLoading(false);
                if (state.data.data != null) {
                  Get.toNamed(forgotOTPPageRoute, parameters: {
                    'method': isEmail ? 'email' : 'phone',
                    'requestId': "${state.data.data!['request_id']}",
                    'email': isEmail ? emailController.text : '',
                    'countryCallingCode':
                        !isEmail ? country!.dialCode ?? '' : '',
                    'phoneNumber': !isEmail ? phoneController.text : '',
                  });
                }
              }
              if (state is CandidateForgotPasswordFail) {
                changeLoading(false);
                if (state.message != '') {
                  showErrorSnackBar(state.message);
                }
              }
            }))
      ],
    );
  }

  _checkValidation() {
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
    _requestValidation();
  }

  _requestValidation() {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateForgotPasswordRequestParams params =
        CandidateForgotPasswordRequestParams(
      path: isEmail ? 'email' : 'phone',
      email: isEmail ? emailController.text.toString() : null,
      countryCallingCode: !isEmail ? int.parse(country!.dialCode ?? '') : null,
      phoneNumber: !isEmail ? int.parse(phoneController.text) : null,
    );
    candidateBloc.add(CandidateForgotPasswordRequested(params: params));
  }

  Widget getUserField(bool isEmail) {
    if (isEmail) {
      return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(StringConst.enterEmailText.tr,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.normal))),
        getTextField(emailController, StringConst.emailAddressPlaceholder,
            prefixIconPath: 'assets/icons/sms.png')
      ]);
    }
    return _getPhoneNumber;
  }

  Widget get _getPhoneNumber => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(StringConst.enterPhoneNumberText.tr,
            textAlign: TextAlign.left,
            style: const TextStyle(
                color: AppColors.white,
                fontSize: 15,
                fontWeight: FontWeight.normal)),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 160,
                  child: PhoneNumberDropdownItem(
                      initialValue: appLocale,
                      title: StringConst.countryText,
                      onValueChanged: (Country c) {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            country = c;
                            appLocale = country!.name!;
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => Get.back(),
          child: const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Icon(
              Iconsax.arrow_left,
              color: AppColors.white,
            ),
          ),
        ),
        Text(
          StringConst.forgetPasswordText.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(
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

  //Forgot Password Textfield
  Widget getTextField(TextEditingController controller, String title,
      {String? prefixIconPath,
      TextInputType? textInputType,
      EdgeInsetsGeometry? fieldPadding}) {
    return CustomTextField(
      prefixIcon: prefixIconPath == null
          ? null
          : Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                bottom: 12.0,
              ),
              child: CustomImageView(
                image: prefixIconPath,
                height: 10.0,
              )),
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
