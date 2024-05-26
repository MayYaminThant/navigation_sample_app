part of '../../views.dart';

class ForgotOTPSection extends StatefulWidget {
  const ForgotOTPSection({super.key});

  @override
  State<ForgotOTPSection> createState() => _ForgotOTPSectionState();
}

class _ForgotOTPSectionState extends State<ForgotOTPSection>
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

  final TextEditingController otpController = TextEditingController();
  String email = '';
  int countryCallingCode = 0;
  int phoneNumber = 0;

  // _getCandidateData() async {
  //   Box box = await Hive.openBox(DBUtils.candidateTableName);
  //   setState(() {
  //     candidateData = box.get('forget_user');
  //   });
  //   _initializeDatas();
  // }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    //_getCandidateData();
    attemptTimerList.addAll(kAttemptTimerList);
    _initializeDatas();
    super.initState();
  }

  _initializeDatas() {
    if (Get.parameters.isNotEmpty) {
      method = Get.parameters['method'] ?? '';
      requestId = Get.parameters['requestId'] ?? '';
      email = Get.parameters['email'] ?? '';
      countryCallingCode = Get.parameters['countryCallingCode'] != ''
          ? int.parse(Get.parameters['countryCallingCode'].toString())
          : 0;
      phoneNumber = Get.parameters['phoneNumber'] != ''
          ? int.parse(Get.parameters['phoneNumber'].toString())
          : 0;

      startTimer();
      //method != 'email' ? _requestVonage() : _requestEmailVerify();
      Future.delayed(Duration.zero, () {
        if (context.mounted) {
          showSuccessSnackBar(
              'Verification code was ${index != 0 ? 'resent' : 'sent'} successfully.');
        }
      });
    }
  }

  //Email Verify API Request
  _requestEmailVerify() async {
    Loading.showLoading(message: StringConst.loadingText);
    requestId = await OtpVerification.requestOtp(
            email,
            int.parse((attemptTimerList[index] / 60).toStringAsFixed(0)),
            VerificationMethod.email) ??
        "";
    startTimer();
  }

  //Email Verify API Request
  _verifyEmailOTP() async {
    Map data = await OtpVerification.verifyOtp(
            requestId, otpController.text, VerificationMethod.email)
        as Map<String, dynamic>;

    if (data['status'] == 'completed') {
      Get.toNamed(resetPasswordPageRoute, parameters: {
        'request_id': requestId,
        'method': 'email',
        'email': email,
      });
    } else {
      showErrorSnackBar(data['message'] ?? '');
      setState(() {
        _enterCodePressed = false;
      });
    }
  }

  //Vonage API Request
  _requestVonage() async {
    Loading.showLoading(message: StringConst.loadingText);
    requestId = await OtpVerification.requestOtp(
            '$countryCallingCode$phoneNumber',
            attemptTimerList[index],
            method == 'email'
                ? VerificationMethod.email
                : VerificationMethod.phone) ??
        "";
    startTimer();
  }

  //Vonage API Request
  Future<void> _verifyVonage() async {
    superPrint("reach forgot_otp_section");
    Map data = await OtpVerification.verifyOtp(
            requestId, otpController.text, VerificationMethod.phone)
        as Map<String, dynamic>;

    if (data['status'] == '0' || data['status'] == 'completed') {
      Get.toNamed(resetPasswordPageRoute, parameters: {
        'request_id': requestId,
        'method': 'phone',
        'countryCallingCode': countryCallingCode.toString(),
        'phoneNumber': phoneNumber.toString()
      });
      return;
    }
    if (context.mounted) {
      showErrorSnackBar('OTP code was not found or has already been used.');
    }
    setState(() {
      _enterCodePressed = false;
    });
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
    return _getForgotOTPScaffold;
  }

  Widget get _getForgotOTPScaffold {
    return BackgroundScaffold(
        availableBack: false,
        scaffold: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.85,
                    child: _getForgotOTPColumn),
                _getBottomActions
              ],
            ),
          ),
        ));
  }

  Widget get _getForgotOTPColumn => Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          _getForgotOTPHeader,
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 60.0),
              child: CustomImageView(image: 'assets/images/otp.png')),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(children: [
                const Text(StringConst.verifyCodeSent,
                    style:
                        TextStyle(color: AppColors.primaryGrey, fontSize: 15)),
                Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
                    child: Text(_getForgotTypeValue(),
                        style: const TextStyle(
                            color: AppColors.primaryGrey, fontSize: 15))),
              ])),
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
              color: AppColors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
      );

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
                  ..onTap = () => _resetTimer()),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget get _getBottomActions => Column(
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
                        method != 'email' ? _verifyVonage() : _verifyEmailOTP();
                      },
                //onPressed: () => Get.toNamed(resetPasswordPageRoute),
              )),
          attemptTimerList[index] == 0 ? _getTextWithAction : _getResendCode
        ],
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
                text: '${formatedTime(time: attemptTimerList[index])}',
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

  _resetTimer() {
    _timer != null ? _timer!.cancel() : null;
    setState(() {
      if (index != attemptTimerList.length - 1) index = index + 1;
    });
    method != 'email' ? _requestVonage() : _requestEmailVerify();
    startTimer();
    Future.delayed(Duration.zero, () {
      if (context.mounted) {
        showSuccessSnackBar(
            'Verification code was ${index != 0 ? 'resent' : 'sent'} successfully.');
      }
    });
  }

  //Format Second to minutes and time
  formatedTime({required int time}) {
    int sec = time % 60;
    int min = (time / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }

  String _getForgotTypeValue() {
    return method == 'email' ? email : '+$countryCallingCode$phoneNumber';
  }
}
