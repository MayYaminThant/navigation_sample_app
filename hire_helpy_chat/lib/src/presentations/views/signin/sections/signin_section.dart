part of '../../views.dart';

class SignInSection extends StatefulWidget {
  const SignInSection({super.key});

  @override
  State<SignInSection> createState() => _SignInSectionState();
}

class _SignInSectionState extends State<SignInSection> {
  final callInvitationController = ZegoUIKitPrebuiltCallController();
  String fcmToken = '';
  final navigatorKey = GlobalKey<NavigatorState>();
  String route = '';

  @override
  void initState() {
    _initializeData();
    super.initState();
  }

  _initializeData() {
    if (Get.parameters.isNotEmpty) {
      route = Get.parameters['route'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployerBloc, EmployerState>(builder: (_, state) {
      return WillPopScope(
          onWillPop: () async => _backButtonPressed(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: getSignInContainer(context),
          ));
    }, listener: (_, state) {
      if (state is EmployerSocialLoginLoading) {
        Loading.showLoading(message: StringConst.loadingText);
      }

      if (state is EmployerUpdateFCMSuccess) {
        if (state.data.data != null) {
          Loading.cancelLoading();
          Get.offAllNamed(rootRoute);
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

  //Stack with background image
  getSignInContainer(BuildContext context) {
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
                  child: _getSignInColumn))),
    );
  }

  Widget get _getSignInColumn {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(children: [
          _getSignInHeader,
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: Text(
                StringConst.signInSubTitle.tr,
                style:
                    const TextStyle(color: AppColors.primaryGrey, fontSize: 15),
              )),
        ]),
        const HeroImage(imagePath: 'assets/images/signin_main.png'),
        Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Column(children: [
              getSignInButton(Iconsax.sms, StringConst.emailSignInText.tr,
                  signInEmailPageRoute),
              getSignInButton(Iconsax.call, StringConst.phoneSignInText.tr,
                  signInPhonePageRoute),
            ])),
        Column(children: [
          const Padding(
              padding: EdgeInsets.only(top: 25.0, bottom: 10.0),
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
          onTap: _backButtonPressed,
          child: const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Icon(
              Iconsax.arrow_left,
              color: AppColors.white,
            ),
          ),
        ),
        Text(
          StringConst.signInTitle.tr,
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

  _backButtonPressed() {
    final loginResume = LoginResume();
    loginResume.resetResumeState();
    route != '' ? Get.back() : Get.offAllNamed(rootRoute);
  }

  getSignInButton(IconData iconData, String label, String to) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: CustomOutlineButton(
        heightButton: 47,
        text: label,
        fontSize: 15,
        icon: Icon(
          iconData,
          color: AppColors.white,
        ),
        onPressed: () => Get.toNamed(to),
      ),
    );
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

  void _requestFCMTokenUpdate(int userId, String token) {
    final employerBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerFCMRequestParams params = EmployerFCMRequestParams(
        fcmToken: fcmToken, userId: userId, token: token);
    employerBloc.add(EmployerUpdateFCMRequested(params: params));
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
}
