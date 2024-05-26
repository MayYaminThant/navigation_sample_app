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
    }
  }

  //Email Verify API Request
  _requestEmailVerify() async {
    Loading.showLoading(message: StringConst.loadingText);
    String? requestID = await OtpVerification.requestOtp(
        email,
        int.parse((attemptTimerList[index] / 60).toStringAsFixed(0)),
        VerificationMethod.email);

    if (requestID != null) {
      requestId = requestID;
      startTimer();
    }
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
      return;
    }

    setState(() {
      _enterCodePressed = false;
    });
    showErrorSnackBar(data['message'] ?? '');
  }

  //Send phone otp
  _requestPhoneOtp() async {
    Loading.showLoading(message: StringConst.loadingText);
    String? requestID = await OtpVerification.requestOtp(
        '$countryCallingCode$phoneNumber',
        attemptTimerList[index],
        VerificationMethod.phone);
    if (requestID != null) {
      requestId = requestID;
      startTimer();
    }
  }

  //Verify phone otp
  _verifyPhoneOtp() async {
    Map data = await OtpVerification.verifyOtp(
            requestId, otpController.text, VerificationMethod.phone)
        as Map<String, dynamic>;
    if (data['status'] == 'completed') {
      Get.toNamed(resetPasswordPageRoute, parameters: {
        'request_id': requestId,
        'method': 'phone',
        'countryCallingCode': countryCallingCode.toString(),
        'phoneNumber': phoneNumber.toString()
      });
      return;
    }
    setState(() {
      _enterCodePressed = false;
    });
    showErrorSnackBar(data['message'] ?? '');
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
        onWillPop: () {},
        scaffold: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
                child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _getForgotOTPColumn,
                  _getBottomActions,
                ],
              ),
            ))));
  }

  Widget get _getForgotOTPColumn => Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          _getForgotOTPHeader,
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 40.0),
              child: HeroImage(imagePath: 'assets/images/otp.png')),
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

  Widget get _getForgotOTPHeader => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          // InkWell(
          //   onTap: () => Get.back(),
          //   child: const Padding(
          //     padding: EdgeInsets.only(left: 20.0),
          //     child: Icon(
          //       Iconsax.arrow_left,
          //       color: AppColors.white,
          //     ),
          //   ),
          // ),
          Text(
            StringConst.enterOTPTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          // const SizedBox(
          //   width: 40,
          // )
        ],
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
                              ? _verifyPhoneOtp()
                              : _verifyEmailOTP();
                        },
                  //onPressed: () => Get.toNamed(resetPasswordPageRoute),
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
    showSuccessSnackBar(
        'Verification code was ${index != 0 ? 'resent' : 'sent'} successfully.');
    const oneSec = Duration(seconds: 1);
    // ignore: unnecessary_new
    _timer = new Timer.periodic(
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

  _resetTimer() {
    _timer!.cancel();
    setState(() {
      if (index != attemptTimerList.length - 1) index = index + 1;
    });
    method != 'email' ? _requestPhoneOtp() : _requestEmailVerify();
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
