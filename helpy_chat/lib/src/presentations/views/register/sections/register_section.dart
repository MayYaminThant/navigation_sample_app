part of '../../views.dart';

class RegisterSection extends StatefulWidget {
  const RegisterSection({super.key});

  @override
  State<RegisterSection> createState() => _RegisterSectionState();
}

class _RegisterSectionState extends State<RegisterSection>
    with SingleTickerProviderStateMixin {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController intialNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retypePasswordConroller = TextEditingController();
  String _verifyType = '';
  Country country = Country(
      name: 'Singapore',
      alpha2Code: 'SG',
      dialCode: '65',
      flagUri: 'assets/flags/sg.png');
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  String referCode = '';
  bool isClicked = false;
  String fcmToken = '';
  String appLocale = '';
  bool isRouted = false;

  @override
  void initState() {
    initialLoad();
    super.initState();
  }

  Future<void> initialLoad() async {
    await _getAppLocaleName();
    _initializeAnimation();
    _showDeclarationModal();
    firebaseTokenListener();
    _initializeData();
  }

  Future<void> _getAppLocaleName() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    appLocale = box.get(DBUtils.country) ?? '';
  }

  void _initializeAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  void _showDeclarationModal() {
    Future.delayed(const Duration(milliseconds: 600), () {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          _animationController.forward(from: 0.0);

          return SlideTransition(
            position: _animation,
            child: const DeclarationModal(),
          );
        },
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CandidateBloc, CandidateState>(builder: (_, state) {
      return _getRegisterScaffold;
    }, listener: (_, state) {
      if (state is CandidateSocialRegisterSuccess) {
        if (state.data.data != null) {
          DBUtils.saveNewData(state.data.data, DBUtils.candidateTableName);
          User user = UserModel.fromJson(state.data.data!['data']);
          _requestFCMTokenUpdate(user.id!, user.token!);
        }
      }

      if (state is CandidateSocialRegisterFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is CandidateUpdateFCMSuccess) {
        if (state.data.data != null) {
          Loading.cancelLoading();
          Get.offNamed(verifiedSuccessPageRoute,
              parameters: {'type': 'social'});
        }
      }

      if (state is CandidateUpdateFCMFail) {
        Loading.cancelLoading();
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is CandidateCheckVerifiedSuccess) {
        Loading.cancelLoading();
        _saveRegisterData();
        routeToVerify();
      }

      if (state is CandidateCheckVerifiedFail) {
        Loading.cancelLoading();
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  void routeToVerify() {
    if (isRouted == false) {
      isRouted = true;
      Get.toNamed(verifyOTPPageRoute, parameters: {
        'receiver': _verifyType == 'Verify Account Via Phone Number'
            ? '${country.dialCode}${phoneNumberController.text}'
            : emailController.text,
        'method':
            _verifyType == 'Verify Account Via Phone Number' ? 'sms' : 'email'
      });
    }
  }

  Widget get _getRegisterScaffold {
    return WillPopScope(
      onWillPop: () async => true,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus == null
            ? null
            : FocusManager.instance.primaryFocus!.unfocus(),
        child: Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: _getRegisterContainer,
          ),
        ),
      ),
    );
  }

  //Stack with background image
  Widget get _getRegisterContainer {
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
        physics: const BouncingScrollPhysics(),
        child: _getRegisterColumn,
      ),
    );
  }

  Widget get _getRegisterColumn {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          _getRegisterHeader,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              StringConst.registerSubTitle.tr,
              style:
                  const TextStyle(color: AppColors.primaryGrey, fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ),
          _getRedeemCodeApplied,
          Table(
            children: [
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: getTextField(firstNameController,
                        StringConst.firstNameText.tr, false, true),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: getTextField(lastNameController,
                          StringConst.lastNameText.tr, false, true)),
                ],
              ),
            ],
          ),
          getTextField(emailController, StringConst.emailText.tr, false, false),
          getTextField(
              passwordController, StringConst.passwordText.tr, true, true),
          getTextField(retypePasswordConroller,
              StringConst.retypePasswordText.tr, true, true),
          _getPhoneNumber,
          const SizedBox(
            height: 10,
          ),
          _getVerifyTypeDropDown,
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: 47,
                child: CustomPrimaryButton(
                  text: StringConst.continueText.tr,
                  onPressed: () => _checkValidations(),
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          const ContinueWithWidget(),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 20,
          ),
          SocialLoginWidget(
            isSignIn: false,
            referCode: referCode != '' ? referCode : null,
          ),
          const SizedBox(
            height: 20,
          ),
          _getTextWithAction
        ],
      ),
    );
  }

  Widget get _getRegisterHeader {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => Get.offNamed(signInPageRoute),
          child: const Icon(
            Iconsax.arrow_left,
            color: AppColors.white,
          ),
        ),
        Text(
          StringConst.registerTitle.tr,
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

  getTextField(TextEditingController controller, String title,
      bool hasSuffixIcon, bool isRequired,
      {TextInputType? inputType}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: CustomTextField(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: controller.text.isEmpty && isRequired && isClicked
                ? Border.all(color: AppColors.red)
                : null,
            color: AppColors.cardColor.withOpacity(0.1)),
        controller: controller,
        textInputType: inputType,
        inputFormatters: [
          if (inputType == TextInputType.number)
            FilteringTextInputFormatter.digitsOnly
        ],
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),

        hasTitle: false,
        hasPrefixIcon: false,
        hasSuffixIcon: hasSuffixIcon,
        obscured: hasSuffixIcon,
        isRequired: true,
        // textFormFieldMargin:
        //     const EdgeInsets.symmetric(vertical: 10),
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
        textStyle: const TextStyle(
          color: AppColors.primaryGrey,
          fontSize: Sizes.textSize12,
        ),
        hintText: title,
        backgroundColor: AppColors.primaryGrey.withOpacity(0.1),
      ),
    );
  }

  Widget get _getTextWithAction {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
                text: 'Already have an account?'.tr,
                style: const TextStyle(color: AppColors.primaryGrey)),
            const TextSpan(
                text: '\t', style: TextStyle(color: AppColors.primaryGrey)),
            TextSpan(
              text: 'Sign In'.tr,
              style: const TextStyle(
                  color: AppColors.secondaryColor, fontWeight: FontWeight.w700),
              recognizer: TapGestureRecognizer()
                ..onTap = () => Get.offNamed(signInPageRoute),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget get _getPhoneNumber => Row(
        children: [
          SizedBox(
            width: 160,
            child: PhoneNumberDropdownItem(
                initialValue: appLocale,
                title: StringConst.countryText,
                onValueChanged: (Country value) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      country = value;
                      appLocale = country.name!;
                    });
                  });
                },
                isCallCode: false,
                prefix: ConfigsKeyHelper.registerPhoneKey),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: getTextField(
                  phoneNumberController,
                  StringConst.phoneNumberText.tr,
                  false,
                  _verifyType == 'Verify Account Via Phone Number'
                      ? true
                      : false,
                  inputType: TextInputType.number)),
        ],
      );

  Widget get _getVerifyTypeDropDown => DropdownItem(
        datas: const [
          'Verify Account Via Email Address',
          'Verify Account Via Phone Number',
        ],
        initialValue: 'Verify Account Via Email Address',
        title: 'Verify Type',
        onValueChanged: (String value) {
          setState(() {
            _verifyType = value;
          });
        },
        suffixIcon: Iconsax.arrow_down5,
        isShowCheckbox: true,
      );

  _checkValidations() {
    List<TextEditingController> requiredControllers = [
      firstNameController,
      lastNameController,
      passwordController,
      retypePasswordConroller,
    ];

    List<String> requiredMessages = const [
      StringConst.firstNameText,
      StringConst.lastNameText,
      StringConst.passwordText,
      StringConst.retypePasswordText
    ];

    setState(() {
      isClicked = true;
    });
    if (_verifyType == 'Verify Account Via Email Address' &&
        emailController.text.isEmpty) {
      showErrorSnackBar(StringConst.invalidEmailText);
    } else if (_verifyType == 'Verify Account Via Phone Number' &&
        phoneNumberController.text.isEmpty) {
      showErrorSnackBar(StringConst.invalidPhoneNumber);
    } else if (requiredControllers.indexWhere((f) => f.text.isEmpty == true) !=
        -1) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => WillPopScope(
                onWillPop: () async => false,
                child: AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  content: SizedBox(
                    width: 300,
                    child: ProfileErrorPopup(
                      controllers: requiredControllers,
                      messages: requiredMessages,
                    ),
                  ),
                ),
              ));
    } else if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(emailController.text) &&
        emailController.text.isNotEmpty) {
      showErrorSnackBar(StringConst.invalidEmailText);
    } else if (passwordController.text != retypePasswordConroller.text) {
      showErrorSnackBar(StringConst.passwordsNotMatchedText);
    } else if (passwordController.text.length < 8) {
      showErrorSnackBar(StringConst.minimumPasswordLengthText);
    } else if (phoneNumberController.text.isNotEmpty &&
        (phoneNumberController.text.length < 7 ||
            phoneNumberController.text.length > 20)) {
      showErrorSnackBar(StringConst.invalidPhoneNumber);
    } else {
      Loading.showLoading(message: StringConst.loadingText);
      _requestCheckVerified();
    }
  }

  void _saveRegisterData() {
    Map<String, dynamic> data = {
      'data': {
        'firstName': firstNameController.text.toString(),
        'lastName': lastNameController.text.toString(),
        'email': emailController.text.toString(),
        'password': passwordController.text.toString(),
        'confrimPassword': retypePasswordConroller.text.toString(),
        'appAlpha2Code': _verifyType == 'Verify Account Via Phone Number'
            ? country.alpha2Code
            : null,
        'countryCallingCode': country.dialCode,
        'phoneNumber': phoneNumberController.text.isNotEmpty
            ? phoneNumberController.text
            : null,
        'referCode': referCode,
      }
    };
    DBUtils.saveNewData(data, 'temp_register');
  }

  void _initializeData() {
    if (Get.parameters.isNotEmpty) {
      referCode = Get.parameters['refer_code'] ?? '';
    }
  }

  Widget get _getRedeemCodeApplied => referCode != ''
      ? Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Container(
            width: MediaQuery.of(context).size.width - 40,
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            decoration: BoxDecoration(
                color: AppColors.green.withOpacity(0.3),
                borderRadius: const BorderRadius.all(Radius.circular(10.0))),
            child: const Text(
              StringConst.referredCodeAppliedText,
              style: TextStyle(color: AppColors.white, fontSize: 15),
            ),
          ),
        )
      : Container();

  // double _getPopupHeight(List<TextEditingController> requiredControllers) {
  //   double height = 210.0;
  //   for (int i = 0; i < requiredControllers.length; i++) {
  //     if (requiredControllers[i].text.isEmpty) height += 30;
  //   }
  //   return height;
  // }

  void firebaseTokenListener() {
    try {
      iosPermission();

      firebaseMessaging.getToken().then((token) {
        if (token != null) {
          setState(() {
            fcmToken = token;
          });
        }
      });
    } catch (e) {
      // ignore: avoid_print
      superPrint(e);
    }
  }

  void _requestFCMTokenUpdate(int userId, String token) {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateFCMRequestParams params = CandidateFCMRequestParams(
        fcmToken: fcmToken, userId: userId, token: token);
    candidateBloc.add(CandidateUpdateFCMRequested(params: params));
  }

  //Candidate Check Verified
  void _requestCheckVerified() {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateCheckVerifiedRequestParams params =
        CandidateCheckVerifiedRequestParams(
      type:
          _verifyType == 'Verify Account Via Phone Number' ? 'phone' : 'email',
      email: emailController.text.isNotEmpty
          ? emailController.text.toString()
          : null,
      phoneNumber: phoneNumberController.text.isNotEmpty
          ? int.parse(phoneNumberController.text.toString())
          : null,
      countryCode: phoneNumberController.text.isNotEmpty
          ? int.parse(country.dialCode.toString())
          : null,
    );
    candidateBloc.add(CandidateCheckVerifiedRequested(params: params));
  }
}
