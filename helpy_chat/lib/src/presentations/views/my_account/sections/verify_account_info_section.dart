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
    _getCandidateData();
    super.initState();
  }

  _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    Map? candidateData = box.get(DBUtils.candidateTableName);

    if (candidateData != null) {
      setState(() {
        user = UserModel.fromJson(candidateData);
      });
      await _initializeDatas();
    }
  }

  Future<void> _initializeDatas() async {
    if (Get.parameters.isNotEmpty) {
      method = Get.parameters['method'] ?? '';
      email = Get.parameters['email'] ?? '';
      phoneNumber = Get.parameters['phone_number'] ?? '';
      countryCallingCode = Get.parameters['country_calling_code'] ?? '';
      route = Get.parameters['route'] ?? '';
      method != 'email'
          ? await _requestPhoneOtp()
          : await _requestEmailVerify();
    }
  }

  //Email Verify API Request
  Future<void> _requestEmailVerify() async {
    requestId = await OtpVerification.requestOtp(
            email!,
            int.parse((attemptTimerList[index] / 60).toStringAsFixed(0)),
            VerificationMethod.email) ??
        "";
    startTimer();
    Future.delayed(Duration.zero, () {
      if (context.mounted) {
        showSuccessSnackBar(
            'Verification code was ${index != 0 ? 'resent' : 'sent'} successfully.');
      }
    });
  }

  //Email Verify API Request
  Future<void> _verifyEmailOTP() async {
    Map data = await OtpVerification.verifyOtp(
            requestId, otpController.text, VerificationMethod.email)
        as Map<String, dynamic>;
    if (data['status'] == 'completed') {
      _updateCandidateVerification(requestId);
      return;
    }
    showErrorSnackBar(data['message'] ?? '');
    setState(() {
      _enterCodePressed = false;
    });
  }

  //Send phone otp
  Future<void> _requestPhoneOtp() async {
    Loading.showLoading(message: StringConst.loadingText);
    requestId = await OtpVerification.requestOtp(
            '$countryCallingCode$phoneNumber',
            attemptTimerList[index],
            VerificationMethod.phone) ??
        "";
    startTimer();
    Future.delayed(Duration.zero, () {
      if (context.mounted) {
        showSuccessSnackBar(
            'Verification code was ${index != 0 ? 'resent' : 'sent'} successfully.');
      }
    });
  }

  //Verify phone otp
  Future<void> _verifyPhoneOtp() async {
    Map data = await OtpVerification.verifyOtp(
            requestId, otpController.text, VerificationMethod.phone)
        as Map<String, dynamic>;
    if (data['status'] == 'completed') {
      _updateCandidateVerification(requestId);
      return;
    }
    showErrorSnackBar(data['message'] ?? '');
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
    return BlocConsumer<CandidateBloc, CandidateState>(builder: (_, state) {
      return _getForgotOTPScaffold;
    }, listener: (_, state) {
      if (state is CandidateCreateVerificationSuccess) {
        if (state.data.data != null) {
          state.data.data!['data']['token'] = user!.token;
          state.data.data!['data'][DBUtils.candidateTableName] =
              json.decode(json.encode(user!.candidate));
          //superPrint('data ${state.data.data!['data']}');
          DBUtils.saveNewData(state.data.data, DBUtils.candidateTableName);
          // Get.offAllNamed(rootRoute);
          Get.back(result: true);
          showSuccessSnackBar(state.data.data!['message']);
        }
      }

      if (state is CandidateCreateVerificationFail) {
        superPrint(state.props);
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  Widget get _getForgotOTPScaffold {
    return BackgroundScaffold(
        availableBack: false,
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
                  onPressed:  _enterCodePressed
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
    method != 'email' ? await _requestPhoneOtp() : await _requestEmailVerify();
  }

  //Format Second to minutes and time
  String formatedTime({required int time}) {
    int sec = time % 60;
    int min = (time / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }

  //Candidate Verification
  void _updateCandidateVerification(String requestId) {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateUpdateVerificationRequestParams params =
        CandidateUpdateVerificationRequestParams(
            requestId: requestId,
            userId: user!.id,
            token: user!.token,
            countryCode: phoneNumber != null && phoneNumber != ''
                ? int.tryParse(countryCallingCode.toString())
                : null,
            email: email == null
                ? null
                : email!.isEmpty
                    ? null
                    : email!,
            phoneNumber: phoneNumber != null && phoneNumber != ''
                ? int.tryParse("$phoneNumber")
                : null,
            method: method == 'sms' ? 'phone' : "email");
    candidateBloc.add(CandidateCreateVerificationRequested(params: params));
  }
}
