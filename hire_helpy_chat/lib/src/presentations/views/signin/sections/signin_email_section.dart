part of '../../views.dart';

class SignInEmailSection extends StatefulWidget {
  const SignInEmailSection({super.key});

  @override
  State<SignInEmailSection> createState() => _SignInEmailSectionState();
}

class _SignInEmailSectionState extends State<SignInEmailSection> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String fcmToken = '';
  bool isSaveLoginName = true;
  final navigatorKey = GlobalKey<NavigatorState>();
  int singleSessionCount = 0;
  final callInvitationController = ZegoUIKitPrebuiltCallController();
  int profileProgressBar = 3;

  @override
  void initState() {
    super.initState();
    firebaseTokenListener();
    _getSavedLoginName();
  }

  void _getSavedLoginName() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    emailController.text = box.get(DBUtils.email) ?? '';
  }

  void _profileDialog() {
    profileProgressBar == 3
        ? null
        : showErrorSnackBar(
            title: "Your profile has not been fully updated.",
            "Please complete your profile to get priority in our AI Matching.");
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployerBloc, EmployerState>(builder: (_, state) {
      return _getSignInScaffold;
    }, listener: (_, state) {
      if (state is EmployerLoginLoading ||
          state is EmployerSocialLoginLoading) {
        Loading.showLoading(message: StringConst.loadingText);
      }
      if (state is EmployerLoginSuccess) {
        if (state.data.data != null) {
          Loading.cancelLoading();
          DBUtils.saveNewData(state.data.data, DBUtils.employerTableName);
          profileProgressBar = state.data.data!["data"]["employer"] == null
              ? 0
              : int.tryParse(state
                      .data.data!["data"]["employer"]['profile_progress_bar']
                      .toString()) ??
                  0;

          User user = UserModel.fromJson(state.data.data!['data']);

          if (isSaveLoginName) {
            DBUtils.saveString(user.email.toString(), DBUtils.email);
          } else {
            DBUtils.clearData(DBUtils.email);
          }

          _loginToZegoCloud(user);
          _requestFCMTokenUpdate(user.id!, user.token!);
        }
      }

      if (state is EmployerLoginFail) {
        Loading.cancelLoading();
        if (state.message.contains("DELETED")) {
          Get.offAllNamed(accountDeletePage);
          return;
        } else if (state.message.contains("PROBATION")) {
          Get.offAllNamed(accountUnderProbation);
          return;
        }

        singleSessionCount = singleSessionCount + 1;
        showErrorSnackBar(state.message);
      }

      if (state is EmployerUpdateFCMSuccess) {
        if (state.data.data != null) {
          Loading.cancelLoading();
          Get.offAllNamed(rootRoute);
          final loginResume = LoginResume();
          if (!loginResume.resumeAvailable) {
            _profileDialog();
          }
        }
      }

      if (state is EmployerUpdateFCMFail) {
        Loading.cancelLoading();
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is EmployerSocialLoginSuccess) {
        if (state.data.data != null) {
          Loading.cancelLoading();
          DBUtils.saveNewData(state.data.data, DBUtils.employerTableName);

          User user = UserModel.fromJson(state.data.data!['data']);
          _loginToZegoCloud(user);
          _requestFCMTokenUpdate(user.id!, user.token!);
        }
      }

      if (state is EmployerSocialLoginFail) {
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

  Widget get _getSignInScaffold {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _getSignInContainer,
    );
  }

  //Stack with background image
  Widget get _getSignInContainer {
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
              child: _getSignInColumn),
        )));
  }

  Widget get _getSignInColumn {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _getSignInHeader,
            const SizedBox(height: 35.0),
            getTextField(emailController, StringConst.enterEmailText.tr,
                StringConst.emailAddressPlaceholder.tr, false, TextInputType.emailAddress, [AutofillHints.email]),
            getTextField(passwordController, StringConst.enterPasswordText.tr,
                StringConst.passwordPlaceholder, true, TextInputType.text, [AutofillHints.password]),
            _getRememberMeAndForgot,
            Padding(
              padding:
                  const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
              child: CustomPrimaryButton(
                heightButton: 47,
                borderRadius: 30,
                text: StringConst.signInText,
                onPressed: () {
                  if (singleSessionCount >= 3) {
                    showCaptchaModal();
                  } else {
                    _verifyFields();
                  }
                },
              ),
            ),
          ],
        ),
        Column(children: [
          const Padding(
              padding: EdgeInsets.only(top: 50.0, bottom: 10.0),
              child: ContinueWithSocial()),
          _getTextWithAction
        ]),
      ],
    );
  }

  Widget get _getSignInHeader {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: 25,
                child: InkWell(
                  onTap: () => Get.offNamed(signInPageRoute),
                  child: const Icon(
                    Iconsax.arrow_left,
                    color: AppColors.white,
                  ),
                )),
            Text(
              StringConst.emailSignInText.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
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

  getTextField(TextEditingController controller, String label,
      String placeholder, bool hasSuffixIcon, TextInputType textInputType, Iterable<String>? autoFillHints) {
    return Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(label,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.normal)),
          ),
          CustomTextField(
            backgroundColor: AppColors.primaryGrey.withOpacity(0.1),
            controller: controller,
            textInputType: textInputType,
            autofillHints: autoFillHints,
            obscured: hasSuffixIcon ? true : false,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
            hasPrefixIcon: false,
            hasTitle: true,
            isRequired: true,
            hasSuffixIcon: hasSuffixIcon,
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
            hintText: placeholder,
          ),
        ]));
  }

  Widget get _getTextWithAction {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
              text: "Don't have an account?".tr,
              style: const TextStyle(color: AppColors.primaryGrey)),
          const TextSpan(
              text: '\t', style: TextStyle(color: AppColors.primaryGrey)),
          TextSpan(
              text: 'Register'.tr,
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
        padding: const EdgeInsets.only(left: 20.0, right: 25.0, top: 5.0),
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
                  child: const Text(StringConst.rememberMeText,
                      style: TextStyle(color: AppColors.primaryGrey)),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => Get.offNamed(forgotPasswordPageRoute,
                arguments: ForgotPasswordSectionParams(isEmail: true)),
            child: const Text(
              StringConst.forgetPasswordText,
              style: TextStyle(color: AppColors.primaryGrey),
            ),
          )
        ]));
  }

  _verifyFields() {
    if (emailController.text.isEmpty) {
      showErrorSnackBar('Please enter your email address.');
    } else if (passwordController.text.isEmpty) {
      showErrorSnackBar('Please enter your password.');
    } else {
      _createSignIn();
    }
  }

  void _createSignIn() {
    final employerBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerLoginRequestParams params = EmployerLoginRequestParams(
      path: 'email',
      email: emailController.text,
      password: passwordController.text,
    );
    employerBloc.add(EmployerLoginRequested(params: params));
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
      print(e);
    }
  }

  void _requestFCMTokenUpdate(int userId, String token) {
    final candidateBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerFCMRequestParams params = EmployerFCMRequestParams(
        fcmToken: fcmToken, userId: userId, token: token);
    candidateBloc.add(EmployerUpdateFCMRequested(params: params));
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
      print('zim error $onError');
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
      appID: kZegoAppId,
      // your appid
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
          int minCallLength =
              int.parse(await _getConfigsData('MIN_CALL_TIME_LENGTH'));

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
        (await DBUtils.getEmployerConfigs('configs'))
            .map((e) => ConfigModel.fromJson(e)));

    Config config = data[data.indexWhere((e) => e.name == value)];

    return config.value;
  }

  showCaptchaModal() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PhluidSliderCaptch(
          onValueChanged: (bool value) {
            if (value) {
              _verifyFields();
              Navigator.of(context).pop();
            }
          },
        );
      },
    );
  }
}
