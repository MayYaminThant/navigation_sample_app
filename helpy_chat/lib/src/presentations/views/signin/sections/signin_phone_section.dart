part of '../../views.dart';

class SignInPhoneSection extends StatefulWidget {
  const SignInPhoneSection({super.key});

  @override
  State<SignInPhoneSection> createState() => _SignInPhoneSectionState();
}

class _SignInPhoneSectionState extends State<SignInPhoneSection> {
  String country = '';
  Country? phoneCountry;
  int countryCallCode = 0;
  String fcmToken = '';
  bool isSaveLoginName = true;
  final navigatorKey = GlobalKey<NavigatorState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  int singleSessionCount = 0;
  final callInvitationController = ZegoUIKitPrebuiltCallController();
  Box? box;

  @override
  void initState() {
    _getSavedLoginName();
    super.initState();
    firebaseTokenListener();
  }

  void _getSavedLoginName() async {
    box = await Hive.openBox(DBUtils.dbName);
    if (box != null) {
      phoneController.text = box!.get(DBUtils.phone) ?? '';
      country =
          box!.get(DBUtils.phoneCountry) ?? box!.get(DBUtils.country) ?? '';
      singleSessionCount = box!.get(phoneController.text) ?? 0;
    }
  }

  getTitleTextField(
      {required TextEditingController controller,
      required String label,
      required String placeholder,
      required bool hasSuffixIcon}) {
    return Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(label.tr,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.normal)),
          ),
          getTextField(controller, placeholder, hasSuffixIcon),
        ]));
  }

  getTextField(
      TextEditingController controller, String placeholder, bool hasSuffixIcon,
      [TextInputType? textInputType, EdgeInsetsGeometry? textFormFieldMargin]) {
    return CustomTextField(
      backgroundColor: AppColors.primaryGrey.withOpacity(0.1),
      controller: controller,
      textInputType: textInputType ?? TextInputType.text,
      inputFormatters: [
        if (textInputType == TextInputType.number)
          FilteringTextInputFormatter.digitsOnly
      ],
      obscured: hasSuffixIcon ? true : false,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
      hasPrefixIcon: false,
      hasTitle: true,
      isRequired: true,
      hasSuffixIcon: hasSuffixIcon,
      textFormFieldMargin: textFormFieldMargin ??
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
      hintText: placeholder,
    );
  }

  firebaseTokenListener() {
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

  Widget get _getSignInScaffold {
    return Scaffold(
      body: _getSignInContainer,
    );
  }

  //Stack with background image
  Widget get _getSignInContainer {
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
        child: Padding(
            padding: const EdgeInsets.only(top: 70.0, bottom: 30.0),
            child: _getSignInColumn),
      ),
    );
  }

  Widget get _getSignInColumn {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _getSignInHeader,
        Padding(
          padding: const EdgeInsets.only(top: 35.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _getPhoneNumber,
            getTitleTextField(
                controller: passwordController,
                label: StringConst.enterPasswordText,
                placeholder: StringConst.passwordPlaceholder,
                hasSuffixIcon: true),
            _getRememberMeAndForgot,
            Padding(
              padding:
                  const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
              child: CustomPrimaryButton(
                heightButton: 50,
                text: StringConst.signInText.tr,
                onPressed: () {
                  if (singleSessionCount >= 3) {
                    showCaptchaModal();
                  } else {
                    _verifyFields();
                  }
                },
              ),
            ),
          ]),
        ),
        Expanded(child: Container()),
        Column(children: [
          const Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: ContinueWithSocial()),
          _getTextWithAction
        ]),
      ],
    );
  }

  Widget get _getSignInHeader {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => Get.offNamed(signInPageRoute),
          child: const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Icon(
              Iconsax.arrow_left,
              color: AppColors.white,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Text(
            StringConst.phoneSignInText,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          width: 40,
        )
      ],
    );
  }

  Widget get _getPhoneNumber => Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
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
                      initialValue: country,
                      title: StringConst.countryText,
                      onValueChanged: (Country country) {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            phoneCountry = country;
                            countryCallCode =
                                int.parse(country.dialCode ?? '65');
                          });
                        });
                      },
                      isCallCode: false,
                      prefix: ConfigsKeyHelper.loginPhoneKey),
                ),
                Expanded(
                    child: getTextField(
                        phoneController,
                        StringConst.phoneNumberOnlyText,
                        false,
                        TextInputType.number,
                        const EdgeInsets.only(left: 10.0))),
              ],
            ))
      ]));

  Widget get _getTextWithAction {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
              text: StringConst.dontHaveAccount.tr,
              style: const TextStyle(color: AppColors.primaryGrey)),
          const TextSpan(
              text: '\t', style: TextStyle(color: AppColors.primaryGrey)),
          TextSpan(
              text: StringConst.register.tr,
              style: const TextStyle(
                  color: AppColors.secondaryColor, fontWeight: FontWeight.w700),
              recognizer: TapGestureRecognizer()
                ..onTap = () => Get.toNamed(registerPageRoute)),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget get _getRememberMeAndForgot {
    return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
        child:
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              CustomCheckBox(
                initialValue: isSaveLoginName,
                onValueChanged: (bool value) {
                  setState(() {
                    isSaveLoginName = value;
                  });
                },
                trailing: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Text(StringConst.rememberMeText.tr,
                      style: const TextStyle(color: AppColors.primaryGrey)),
                ),
              ),
            ],
          ),
          GestureDetector(
              onTap: () => Get.offNamed(forgotPasswordPageRoute,
                  arguments: ForgotPasswordSectionParams(isEmail: false)),
              child: Padding(
                padding: const EdgeInsets.only(right: 3),
                child: Text(StringConst.forgetPasswordText.tr,
                    style: const TextStyle(color: AppColors.primaryGrey)),
              ))
        ]));
  }

  _verifyFields() {
    if (phoneController.text.isEmpty) {
      showErrorSnackBar(StringConst.enterPhoneNumberText);
    } else if (passwordController.text.isEmpty) {
      showErrorSnackBar(StringConst.enterPasswordText);
    } else if (phoneController.text.isNotEmpty &&
        (phoneController.text.length < 7 || phoneController.text.length > 20)) {
      showErrorSnackBar(StringConst.invalidPhoneNumber);
    } else if (passwordController.text.length < 8) {
      showErrorSnackBar(StringConst.minimumPasswordLengthText);
    } else {
      if (phoneCountry != null) {
        DBUtils.saveString("${phoneCountry!.name}", DBUtils.phoneCountry);
      }
      _createSignIn();
    }
  }

  void _createSignIn() {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateLoginRequestParams params = CandidateLoginRequestParams(
        path: 'phone',
        countryCallingCode: countryCallCode,
        phoneNumber: int.parse(phoneController.text.toString()),
        password: passwordController.text,
        fcmToken: fcmToken
        );
    candidateBloc.add(CandidateLoginRequested(params: params));
  }

  void _requestFCMTokenUpdate(int userId, String token) {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateFCMRequestParams params = CandidateFCMRequestParams(
        fcmToken: fcmToken, userId: userId, token: token);
    candidateBloc.add(CandidateUpdateFCMRequested(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CandidateBloc, CandidateState>(builder: (_, state) {
      return _getSignInScaffold;
    }, listener: (_, state) {
      if (state is CandidateLoginLoading ||
          state is CandidateSocialLoginLoading) {
        Loading.showLoading(message: StringConst.loadingText);
      }
      if (state is CandidateLoginSuccess) {
        if (state.data.data != null) {
          Loading.cancelLoading();
          DBUtils.saveNewData(state.data.data, DBUtils.candidateTableName);
          setState(() {
            singleSessionCount = singleSessionCount + 1;
            if (box != null) {
              box!.put(phoneController.text, singleSessionCount);
            }
          });
          User user = UserModel.fromJson(state.data.data!['data']);

          if (isSaveLoginName) {
            DBUtils.saveString(user.phoneNumber.toString(), DBUtils.phone);
          } else {
            DBUtils.clearData(DBUtils.phone);
          }

          _loginToZegoCloud(user);
          _requestFCMTokenUpdate(user.id!, user.token!);
        }
      }

      if (state is CandidateLoginFail) {
        Loading.cancelLoading();
        if (state.message != '') {
          setState(() {
            singleSessionCount = singleSessionCount + 1;
            if (box != null) {
              box!.put(phoneController.text, singleSessionCount);
            }
          });
          if (state.message.contains('status')) {
            Get.offAllNamed(unauthenicatedPageRoute,
                parameters: {'data': state.message});
          } else {
            showErrorSnackBar(state.message);
          }
        }
      }

      if (state is CandidateUpdateFCMSuccess) {
        if (state.data.data != null) {
          Loading.cancelLoading();
          Get.offAllNamed(rootRoute);
        }
      }

      if (state is CandidateUpdateFCMFail) {
        Loading.cancelLoading();
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is CandidateForgotPasswordSuccess) {
        if (state.data.data != null) {
          DBUtils.saveNewData(state.data.data, 'forget_user');
          Get.toNamed(
            accountCheckPageRoute,
          );
        }
      }

      if (state is CandidateForgotPasswordFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is CandidateSocialLoginSuccess) {
        if (state.data.data != null) {
          Loading.cancelLoading();
          DBUtils.saveNewData(state.data.data, DBUtils.candidateTableName);

          User user = UserModel.fromJson(state.data.data!['data']);
          _requestFCMTokenUpdate(user.id!, user.token!);
        }
      }

      if (state is CandidateSocialLoginFail) {
        Loading.cancelLoading();

        if (state.message != '') {
          if (state.message.contains('status')) {
            Get.offAllNamed(unauthenicatedPageRoute,
                parameters: {'data': state.message});
          } else {
            showErrorSnackBar(state.message);
          }
        }
      }
    });
  }

  void showCaptchaModal() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PhluidSliderCaptch(
          onValueChanged: (bool value) {
            if (value) {
              _verifyFields();
              setState(() {
                singleSessionCount = 0;
              });
              Navigator.of(context).pop();
            }
          },
        );
      },
    );
  }

  void _loginToZegoCloud(User user) async {
    try {
      ZIMAppConfig appConfig = ZIMAppConfig();
      appConfig.appID = kZegoAppId;
      appConfig.appSign = kZegoAppSign;
      ZIM.create(appConfig);
      ZIMUserInfo userInfo = ZIMUserInfo();

      userInfo.userID = user.id.toString();
      userInfo.userName =
          StringUtils.getFullName(user.firstName ?? '', user.lastName ?? '');

      await ZIM.getInstance()!.login(userInfo, '');
    } on PlatformException catch (onError) {
      superPrint('zim error $onError');
    }
    loginToZimKit(user);
    onUserLogin(user.id.toString(),
        StringUtils.getFullName(user.firstName ?? '', user.lastName ?? ''));
  }

  loginToZimKit(User user) async {
    await ZIMKit()
        .connectUser(
            id: user.id.toString(),
            name: StringUtils.getFullName(
                user.firstName ?? '', user.lastName ?? ''))
        .then((errorCode) {});
  }

  void onUserLogin(String id, String name) {
    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: kZegoAppId, // your appid
      appSign: kZegoAppSign,
      userID: id,
      userName: name,
      iOSNotificationConfig: ZegoIOSNotificationConfig(
        isSandboxEnvironment: true,
      ),
      certificateIndex: ZegoSignalingPluginMultiCertificate.firstCertificate,
      controller: callInvitationController,
      notifyWhenAppRunningInBackgroundOrQuit: true,
      plugins: [ZegoUIKitSignalingPlugin()],
      requireConfig: (ZegoCallInvitationData data) {
        var config = ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall();

        // Modify your custom configurations here.
        config.durationConfig.isVisible = true;
        config.durationConfig.onDurationUpdate = (Duration duration) async {
          int maxCallLength =
              int.parse(await _getConfigsData('MAX_CALL_TIME_LENGTH'));
          // int minCallLength =
          //     int.parse(await _getConfigsData('MIN_CALL_TIME_LENGTH'));

          if (duration.inSeconds >= maxCallLength * 60) {
            callInvitationController.hangUp(navigatorKey.currentState!.context);
          }
        };

        return config;
      },
    );
  }

  _getConfigsData(String value) async {
    List<Config> data = List<Config>.from(
        (await DBUtils.getCandidateConfigs('configs'))
            .map((e) => ConfigModel.fromJson(e)));

    Config config = data[data.indexWhere((e) => e.name == value)];

    return config.value;
  }
}
