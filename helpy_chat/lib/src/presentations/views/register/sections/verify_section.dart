part of '../../views.dart';

class VerifyOTPSection extends StatefulWidget {
  const VerifyOTPSection({super.key});

  @override
  State<VerifyOTPSection> createState() => _VerifyOTPSectionState();
}

class _VerifyOTPSectionState extends State<VerifyOTPSection>
    with WidgetsBindingObserver {
  Timer? _timer;
  int index = 0;
  List<int> attemptTimerList = [];
  int lastTimerTickUnix =
      (DateTime.now().millisecondsSinceEpoch / 1000).floor();
  bool _enterCodePressed = false;

  //Vonage
  String requestId = '';
  String method = '';
  String receiverValue = '';
  String fcmToken = '';

  final TextEditingController otpController = TextEditingController();
  String language = '';
  String country = '';

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    attemptTimerList.addAll(kAttemptTimerList);
    _initializeDatas();
    firebaseTokenListener();
    super.initState();
  }

  Future<void> _initializeDatas() async {
    if (Get.parameters.isNotEmpty) {
      receiverValue = Get.parameters['receiver'] ?? '';
      method = Get.parameters['method'] ?? '';

      Box box = await Hive.openBox(DBUtils.dbName);
      language = box.get(DBUtils.language) ?? '';
      country = box.get(DBUtils.country) ?? '';
      method != 'email' ? _requestVonage() : _requestEmailVerify();
    }
  }

  //Email Verify API Request
  Future<void> _requestEmailVerify() async {
    Loading.showLoading(message: StringConst.loadingText);
    requestId = await OtpVerification.requestOtp(
            receiverValue,
            int.parse((attemptTimerList[index] / 60).toStringAsFixed(0)),
            VerificationMethod.email) ??
        "";
    startTimer();
  }

  //Email Verify API Request
  Future<void> _verifyEmailOTP() async {
    Map data = await OtpVerification.verifyOtp(
            requestId, otpController.text, VerificationMethod.email)
        as Map<String, dynamic>;

    if (data['status'] == 'completed') {
      Map registerData = await _getTempCandidateData();
      _registerCandidateAccount(registerData);
    } else {
      showErrorSnackBar(data['message'] ?? '');
      setState(() {
        _enterCodePressed = false;
      });
    }
  }

  //Vonage API Request
  Future<void> _requestVonage() async {
    Loading.showLoading(message: StringConst.loadingText);
    requestId = await OtpVerification.requestOtp(
            receiverValue,
            attemptTimerList[index],
            method == 'email'
                ? VerificationMethod.email
                : VerificationMethod.phone) ??
        "";
    startTimer();
  }

  //Vonage API Request
  Future<void> _verifyVonage() async {
    superPrint("reach verify_section");
    Map data = await OtpVerification.verifyOtp(
            requestId, otpController.text, VerificationMethod.phone)
        as Map<String, dynamic>;

    if (data['status'] == 'completed') {
      Map<dynamic, dynamic> registerData = await _getTempCandidateData();
      _registerCandidateAccount(registerData);
    } else {
      String message = data['status'] ?? data['detail'] ?? '';
      String verifiedMessage = message !=
              "Request '$requestId' was not found or it has been verified already."
          ? message
          : 'OTP code was not found or it has been verified already';
      if (context.mounted) {
        showErrorSnackBar(verifiedMessage);
      }
      setState(() {
        _enterCodePressed = false;
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer!.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final int currentTimestamp =
          (DateTime.now().millisecondsSinceEpoch / 1000).floor();
      final int timeSinceLastTick = currentTimestamp - lastTimerTickUnix;
      final int currentTimerSeconds = attemptTimerList[index];

      if (timeSinceLastTick > currentTimerSeconds) {
        setState(() {
          attemptTimerList[index] = 0;
        });
        return;
      }

      setState(() {
        attemptTimerList[index] -= timeSinceLastTick;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CandidateBloc, CandidateState>(builder: (_, state) {
      return _getForgotOTPScaffold;
    }, listener: (_, state) {
      if (state is CandidateRegisterSuccess) {
        if (state.data.data != null) {
          DBUtils.saveNewData(state.data.data, DBUtils.candidateTableName);
          User user = UserModel.fromJson(state.data.data!['data']);
          _requestFCMTokenUpdate(user.id!, user.token!);
        }
      }

      if (state is CandidateRegisterFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is CandidateUpdateFCMSuccess) {
        if (state.data.data != null) {
          Loading.cancelLoading();
          Get.offNamed(verifiedSuccessPageRoute);
        }
      }

      if (state is CandidateUpdateFCMFail) {
        Loading.cancelLoading();
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  Widget get _getForgotOTPScaffold {
    return BackgroundScaffold(
        scaffold: Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          _getForgotOTPColumn,
          Align(
            alignment: Alignment.bottomCenter,
            child: _getBottomActions,
          )
        ],
      ),
    ));
  }

  Widget get _getForgotOTPColumn => Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          _getForgotOTPHeader,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              child: Text(
                '${StringConst.verifyCodeSend} ${method == 'sms' ? 'phone number.' : 'email address.'}',
                style: const TextStyle(
                    color: AppColors.primaryGrey, fontSize: 15, height: 2),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              child: const Text(
                StringConst.enterCodeHere,
                style: TextStyle(
                    color: AppColors.primaryGrey, fontSize: 15, height: 2),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          OTPField(
            controller: otpController,
          ),
        ],
      );

  Widget get _getForgotOTPHeader => const Center(
          child: Text(
        StringConst.enterOTPTitle,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: AppColors.white, fontSize: 25, fontWeight: FontWeight.bold),
      ));

  Widget get _getTextWithAction {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Text.rich(
        TextSpan(
          children: [
            const TextSpan(
                text: 'Didn’t receive Code?   ',
                style: TextStyle(fontSize: 12, color: AppColors.primaryGrey)),
            TextSpan(
                text: 'Resend OTP',
                style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.w700),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async => await _resetTimer()),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget get _getBottomActions => SizedBox(
        height: 120,
        child: Column(
          children: [
            SizedBox(
                width: 330,
                child: CustomPrimaryButton(
                  text: StringConst.enterCodeText,
                  onPressed: _enterCodePressed
                      ? null
                      : () {
                          setState(() {
                            _enterCodePressed = true;
                          });
                          method != 'email'
                              ? _verifyVonage()
                              : _verifyEmailOTP();
                        },
                )),
            attemptTimerList[index] == 0 ? _getTextWithAction : _getResendCode
          ],
        ),
      );

  Widget get _getResendCode {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
                text: 'Resend Code in ',
                style: TextStyle(
                    fontSize: 12,
                    color: AppColors.primaryGrey.withOpacity(0.5))),
            TextSpan(
                text: formatedTime(time: attemptTimerList[index]),
                style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.primaryGrey,
                    fontWeight: FontWeight.w700)),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  void startTimer() {
    if (requestId.isNotEmpty) {
      showSuccessSnackBar(
          'Verification code was ${index != 0 ? 'resent' : 'sent'} successfully.');
      const oneSec = Duration(seconds: 1);
      _timer != null ? _timer!.cancel() : null;
      _timer = Timer.periodic(
        oneSec,
        (Timer timer) {
          if (attemptTimerList[index] == 0) {
            setState(() {
              timer.cancel();
            });
          } else {
            lastTimerTickUnix =
                (DateTime.now().millisecondsSinceEpoch / 1000).floor();
            setState(() {
              attemptTimerList[index]--;
            });
          }
        },
      );
    }
  }

  Future<void> _resetTimer() async {
    _timer!.cancel();
    setState(() {
      if (index != attemptTimerList.length - 1) index = index + 1;
    });
    method != 'email' ? await _requestVonage() : await _requestEmailVerify();
  }

  //Format Second to minutes and time
  String formatedTime({required int time}) {
    int sec = time % 60;
    int min = (time / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }

  //Register API Call
  void _registerCandidateAccount(Map data) {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateRegisterRequestParams params = CandidateRegisterRequestParams(
      firstName: data['firstName'],
      lastName: data['lastName'],
      email: data['email'] != '' ? data['email'] : null,
      password: data['password'],
      confrimPassword: data['confrimPassword'],
      countryCallingCode:
          data['phoneNumber'] != null ? data['countryCallingCode'] : null,
      phoneNumber: data['phoneNumber'] != null
          ? int.parse(data['phoneNumber'].toString())
          : null,
      verifyMethod: method != 'email' ? 'phone' : method,
      referCode: data['referCode'] != '' ? data['referCode'] : null,
      requestId: requestId,
      appLocale: country,
      preferredLanguage: language,
    );

    candidateBloc.add(CandidateRegisterRequested(params: params));
  }

  //Get Temp Save Data
  Future<Map<dynamic, dynamic>> _getTempCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    return box.get('temp_register');
  }

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
}
