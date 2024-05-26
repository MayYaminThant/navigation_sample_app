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
    return BlocConsumer<CandidateBloc, CandidateState>(builder: (_, state) {
      return BackgroundScaffold(
        onWillPop: () async {
          final loginResume = LoginResume();
          loginResume.resetResumeState();
          route != '' ? Get.back() : Get.offAllNamed(rootRoute);
          return false;
        },
        scaffold: Scaffold(
          resizeToAvoidBottomInset: false,
          body: getSignInContainer,
        ),
      );
    }, listener: (_, state) {
      if (state is CandidateSocialLoginLoading) {
        Loading.showLoading(message: StringConst.loadingText);
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

      if (state is CandidateSocialLoginSuccess) {
        if (state.data.data != null) {
          Loading.cancelLoading();
          DBUtils.saveNewData(state.data.data, DBUtils.candidateTableName);

          User user = UserModel.fromJson(state.data.data!['data']);

          _loginToZegoCloud(user);
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

  //Stack with background image
  Widget get getSignInContainer {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/no-image-bg.png'),
              fit: BoxFit.cover)),
      child: Padding(
          padding: const EdgeInsets.only(top: 70.0, bottom: 30.0),
          child: _getSignInColumn),
    );
  }

  Widget get _getSignInColumn {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _getSignInHeader,
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: Text(
                StringConst.signInSubTitle.tr,
                style:
                    const TextStyle(color: AppColors.primaryGrey, fontSize: 15),
              )),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.0),
              child: CustomImageView(image: 'assets/images/signin_main.png')),
          Padding(
              padding: const EdgeInsets.only(top: 35.0),
              child: Column(children: [
                getSignInButton(Iconsax.sms, false, signInEmailPageRoute),
                getSignInButton(Iconsax.call, true, signInPhonePageRoute),
              ])),
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Column(children: [
              const Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: ContinueWithSocial()),
              _getTextWithAction
            ]),
          ),
        ],
      ),
    );
  }

  Widget get _getSignInHeader {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            final loginResume = LoginResume();
            loginResume.resetResumeState();
            route != '' ? Get.back() : Get.offAllNamed(rootRoute);
          },
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

  Widget getSignInButton(IconData iconData, bool isPhone, String to) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: CustomOutlineButton(
        heightButton: 47,
        text: isPhone
            ? StringConst.phoneSignInText.tr
            : StringConst.emailSignInText.tr,
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

  void _requestFCMTokenUpdate(int userId, String token) {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateFCMRequestParams params = CandidateFCMRequestParams(
        fcmToken: fcmToken, userId: userId, token: token);
    candidateBloc.add(CandidateUpdateFCMRequested(params: params));
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
