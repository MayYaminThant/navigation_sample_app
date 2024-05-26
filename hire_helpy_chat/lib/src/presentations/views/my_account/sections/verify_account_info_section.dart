part of '../../views.dart';

class VerifyAccountInfoSection extends StatefulWidget {
  const VerifyAccountInfoSection({super.key});

  @override
  State<VerifyAccountInfoSection> createState() =>
      _VerifyAccountInfoSectionState();
}

class _VerifyAccountInfoSectionState extends State<VerifyAccountInfoSection>
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
  User? user;
  String? email;
  String? phoneNumber;
  String? countryCallingCode;
  String route = '';

  final TextEditingController otpController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    attemptTimerList.addAll(kAttemptTimerList);
    _getEmployerData();
    super.initState();
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

  _getEmployerData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    Map? employerData = box.get(DBUtils.employerTableName);

    if (employerData != null) {
      setState(() {
        user = UserModel.fromJson(employerData);
      });
      _initializeDatas();
    }
  }

  _initializeDatas() {
    if (Get.parameters.isNotEmpty) {
      method = Get.parameters['method'] ?? '';
      email = Get.parameters['email'] ?? '';
      phoneNumber = Get.parameters['phone_number'] ?? '';
      countryCallingCode = Get.parameters['country_calling_code'] ?? '';
      route = Get.parameters['route'] ?? '';
      method != 'email' ? _requestPhoneOtp() : _requestEmailVerify();
    }
  }

  //Email Verify API Request
  _requestEmailVerify() async {
    String? requestID = await OtpVerification.requestOtp(
        email!,
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
      _updateEmployerVerification(requestId);
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
      _updateEmployerVerification(requestId);
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
  Widget build(BuildContext context) {
    return BlocConsumer<EmployerBloc, EmployerState>(builder: (_, state) {
      return _getForgotOTPScaffold;
    }, listener: (_, state) {
      if (state is EmployerCreateVerificationSuccess) {
        if (state.data.data != null) {
          showSuccessSnackBar(state.data.data!['message']);

          state.data.data!['data']['token'] = user!.token;
          state.data.data!['data'][DBUtils.employerTableName] =
              json.decode(json.encode(user!.employer));
          //print('data ${state.data.data!['data']}');
          DBUtils.saveNewData(state.data.data, DBUtils.employerTableName);
          Get.back(result: true);
        }
      }

      if (state is EmployerCreateVerificationFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  Widget get _getForgotOTPScaffold {
    return BackgroundScaffold(
        onWillPop: () {},
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
    Loading.cancelLoading();
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

  //Employer Verification
  _updateEmployerVerification(String requestId) {
    print("UPDATING EMPLOYER VERIFICATION");
    final employerBloc = BlocProvider.of<EmployerBloc>(context);

    EmployerUpdateVerificationRequestParams params =
        EmployerUpdateVerificationRequestParams(
            requestId: requestId,
            userId: user!.id,
            token: user!.token,
            countryCode: phoneNumber != null && phoneNumber != ''
                ? int.parse(countryCallingCode.toString())
                : null,
            email: method == 'email' ? email! : null,
            phoneNumber: phoneNumber != null && phoneNumber != ''
                ? int.parse(phoneNumber.toString())
                : null,
            method: method == 'sms' ? 'phone' : method);
    employerBloc.add(EmployerCreateVerificationRequested(params: params));
  }
}
