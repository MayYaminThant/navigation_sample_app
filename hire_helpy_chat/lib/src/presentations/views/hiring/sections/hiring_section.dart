part of '../../views.dart';

class HiringSection extends StatefulWidget {
  const HiringSection({
    super.key,
  });

  @override
  State<HiringSection> createState() => _HiringSectionState();
}

class _HiringSectionState extends State<HiringSection> {
  int countryCallCode = 65;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController expectedSalaryController =
      TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController fromTimeController = TextEditingController();
  final TextEditingController toTimeController = TextEditingController();
  User? user;
  Map? employerData;
  String countryName = '';
  String? phoneNumber = '';
  String currency = '';

  final TextEditingController phoneNumberController = TextEditingController();
  bool isLoading = false;
  int? candidateId;
  ZIMKitConversation? conversation;

  @override
  void initState() {
    _getEmployerData();
    _initializeData();
    super.initState();
  }

  _initializeData() {
    if (Get.arguments != null) {
      conversation = Get.arguments['conversation'];
      candidateId = Get.arguments['candidateId'] != null
          ? int.parse(Get.arguments['candidateId']!)
          : null;
    }
  }

  _getEmployerData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    countryName = box.get(DBUtils.country);
    phoneNumber = box.get(DBUtils.phone);
    setState(() {
      employerData = box.get(DBUtils.employerTableName);
      user = UserModel.fromJson(employerData!);
    });
    if (user?.phoneNumberVerifiedDateTime == null) {
      showPhoneVerifyDialog();
    }
  }

  void showPhoneVerifyDialog() {
    showCustomDialogModal(
        title:
            '"Hire this helper through Phluid NOW" can only be used if your phone number is verified.',
        buttonText: "Verify Now!",
        secondaryButtonText: "Back",
        onButtonClick: () {
          Get.toNamed(aboutMePageRoute, parameters: {
            'route': hiringPageRoute,
            'scrollTo': 'verifyPhone'
          });
        },
        onSecondaryButtonClick: () {
          Get.until((route) => route.settings.name == chatDetailPageRoute);
        },
        onWillPop: () async {
          Get.until((route) => route.settings.name == chatDetailPageRoute);
          return false;
        },
        barrierDismissible: false,
        autoDismiss: false);
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final Width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: height,
        width: Width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/no-image-bg.png'),
                fit: BoxFit.fill)),
        child: _getContactUsScaffold,
      ),
    );
  }

  Widget get _getContactUsScaffold {
    return BlocConsumer<EmployerBloc, EmployerState>(builder: (_, state) {
      return Stack(
        children: [
          SingleChildScrollView(
            child: WillPopScope(
          onWillPop: () async {
            Get.until((route) => route.settings.name == chatDetailPageRoute);
            return false;
          }, child: BackgroundScaffold(
                scaffold: Scaffold(
              appBar: _getAppBar,
              drawerScrimColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              body: _getHiringContainer,
            ))),
          ),
          if (isLoading)
            Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ))
        ],
      );
    }, listener: (_, state) {
      if (state is EmployerHiringSuccess) {
        Loading.cancelLoading();
        if (state.data.data != null) {
          _showSuccessInfo();
        }
      }

      if (state is EmployerHiringFail) {
        Loading.cancelLoading();
        setState(() {
          isLoading = false;
        });
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  AppBar get _getAppBar => AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () =>
              Get.until((route) => route.settings.name == chatDetailPageRoute),
          child: const Icon(
            Iconsax.arrow_left,
            color: AppColors.white,
          ),
        ),
        leadingWidth: 52,
        title: Text(
          'Hire this Helper'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w100),
        ),
        elevation: 0.0,
        titleSpacing: 0.0,
        centerTitle: true,
      );

  Widget get _getHiringContainer {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.padding20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _getHiringHeader,
            _getPhoneNumber,
            Table(
              children: [
                _getSpacerTableRow,
                TableRow(
                  children: _getFromTimeDropDown,
                ),
                _getSpacerTableRow,
                TableRow(
                  children: _getToTimeDropDown,
                ),
                _getSpacerTableRow,
                TableRow(
                  children: _getExpectedSalaryDropDown,
                ),
                _getSpacerTableRow,
                TableRow(
                  children: _getExpiryDateDropDown,
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            _getCreateHiringButton
          ],
        ),
      ),
    );
  }

  get _getHiringHeader => RichText(
        text: TextSpan(
          children: <TextSpan>[
            const TextSpan(
              text:
                  'If you are ready to hire this helper, please chose a time slot for Phluid Representative to contact you Directly at ',
              style: TextStyle(color: Colors.grey, height: 2, fontSize: 15),
            ),
            TextSpan(
              text:
                  '+${user?.countryCallingCode ?? ''} ${user?.phoneNumber ?? '-'}',
              style: const TextStyle(
                  color: AppColors.secondaryColor, height: 2, fontSize: 15),
              // recognizer: TapGestureRecognizer()
              //   ..onTap = () => Get.offAllNamed(aboutMePageRoute)
            ),
            const TextSpan(
              text: ' (or) ',
              style: TextStyle(color: Colors.grey, height: 2, fontSize: 15),
            ),
          ],
        ),
        textAlign: TextAlign.left,
      );

  TableRow get _getSpacerTableRow => const TableRow(children: [
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 20,
        )
      ]);

  List<Widget> get _getExpectedSalaryDropDown {
    return [
      Text(
        'Your Offered salary/ month'.tr,
        style: const TextStyle(color: AppColors.white, fontSize: 16),
      ),
          CurrencyField(
              controller: expectedSalaryController,
              initialValue: countryName,
              textColor: AppColors.white,
              backgroundColor: AppColors.primaryGrey.withOpacity(0.2),
              onValueChanged: (String value) {
                setState(() {
                  currency = value;
                });
              },
              prefix: ConfigsKeyHelper.simpleSearchCurrencyCodeKey),
      //DropdownButton(items: {}, onChanged: onChanged)
    ];
  }

  List<Widget> get _getExpiryDateDropDown {
    return [
      const Text(
        'Offer Expiry Date (Max: 14 days)',
        style: TextStyle(color: AppColors.white, fontSize: 16),
      ),
      SizedBox(
          width: MediaQuery.of(context).size.width,
          child: CustomDatePicker(
            controller: expiryDateController,
            enabled: true,
            backgroundColor: AppColors.primaryGrey.withOpacity(0.2),
            isInitialDate: false,
            isShowPreviousDate: false,
            textColor: AppColors.white,
          ))
    ];
  }

  List<Widget> get _getFromTimeDropDown {
    return [
      const Text(
        'From SGT',
        style: TextStyle(color: AppColors.white, fontSize: 16),
      ),
      SizedBox(
          width: MediaQuery.of(context).size.width,
          child: CustomTimePicker(
            controller: fromTimeController,
            enabled: true,
            backgroundColor: AppColors.primaryGrey.withOpacity(0.2),
            isInitialDate: false,
            isShowPreviousDate: false,
            textColor: AppColors.white,
          ))
    ];
  }

  List<Widget> get _getToTimeDropDown {
    return [
      const Text(
        'To SGT',
        style: TextStyle(color: AppColors.white, fontSize: 16),
      ),
      SizedBox(
          width: MediaQuery.of(context).size.width,
          child: CustomTimePicker(
            controller: toTimeController,
            enabled: true,
            backgroundColor: AppColors.primaryGrey.withOpacity(0.2),
            isInitialDate: false,
            isShowPreviousDate: false,
            textColor: AppColors.white,
          ))
    ];
  }

  _getTextField(TextEditingController controller, String title, int? maxLine,
      bool isRequired,
      {TextInputType? inputType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: CustomTextField(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: controller.text.isEmpty && isRequired
                    ? Border.all(color: AppColors.red)
                    : null,
                color: AppColors.cardColor.withOpacity(0.1)),
            maxLine: maxLine ?? 1,
            backgroundColor: AppColors.primaryGrey.withOpacity(0.1),
            controller: controller,
            textInputType: inputType,
            inputFormatters: [
              if (inputType == TextInputType.number)
                FilteringTextInputFormatter.digitsOnly
            ],
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
            hasPrefixIcon: false,
            hasTitle: true,
            isRequired: true,
            titleStyle: const TextStyle(
              color: AppColors.white,
              fontSize: Sizes.textSize14,
            ),
            hasTitleIcon: false,
            enabledBorder: Borders.noBorder,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(1),
              borderSide: const BorderSide(color: AppColors.white),
            ),
            hintTextStyle:
                const TextStyle(color: AppColors.primaryGrey, fontSize: 14),
            textStyle: const TextStyle(color: AppColors.primaryGrey),
            hintText: title,
          ),
        ),
      ],
    );
  }

  //Check validation for contact us form
  _checkValidations() {
    List<String> requiredControllers = [
      expectedSalaryController.text.isNotEmpty
          ? expectedSalaryController.text.toString()
          : '',
      expiryDateController.text.isNotEmpty
          ? expiryDateController.text.toString()
          : '',
    ];

    List<String> requiredMessages = [
      'Your Offered Salary/Month',
      'Offer Expire Date'
    ];

    if (requiredControllers.indexWhere((f) => f == '' || f == '0') != -1) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                content: Builder(
                  builder: (context) {
                    return SizedBox(
                      height: _getPopupHeight(requiredControllers),
                      width: 300,
                      child: ValueErrorPopup(
                          values: requiredControllers,
                          messages: requiredMessages,
                          nextRoute: '',
                          currentRoute: '',
                          isExit: true),
                    );
                  },
                ),
              ));
    } else if (phoneNumberController.text.isNotEmpty &&
        (phoneNumberController.text.length < 7 ||
            phoneNumberController.text.length > 20)) {
      showErrorSnackBar(StringConst.invalidPhoneNumber);
    } else {
      Loading.showLoading(message: StringConst.loadingText);
      _createHiringMessage();
    }
  }

  void _createHiringMessage() async {
    final EmployerBloc employerBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerHiringRequestParams params = EmployerHiringRequestParams(
      token: employerData != null ? employerData!['token'] : null,
      candidateID: candidateId,
      countryCallingCode:
          phoneNumberController.text.isNotEmpty ? countryCallCode : null,
      phoneNumber: phoneNumberController.text.isNotEmpty
          ? int.parse(phoneNumberController.text.toString())
          : null,
      currency: currency,
      salary: expectedSalaryController.text.isNotEmpty
          ? int.parse(expectedSalaryController.text.toString())
          : null,
      expiryDate: expiryDateController.text,
      fromTime: fromTimeController.text.isNotEmpty
          ? DateFormat.jm().format(
              DateFormat("hh:mm:ss").parse('${fromTimeController.text}:00'))
          : null,
      toTime: toTimeController.text.isNotEmpty
          ? DateFormat.jm().format(
              DateFormat("hh:mm:ss").parse('${toTimeController.text}:00'))
          : null,
    );

    employerBloc.add(EmployerHiringRequested(params: params));
  }

  _getPopupHeight(List<String> requiredControllers) {
    double height = 210.0;
    for (int i = 0; i < requiredControllers.length; i++) {
      if (requiredControllers[i] == '' || requiredControllers[i] == '0') {
        height += 30;
      }
    }
    return height;
  }

  void _showSuccessInfo() {
    Future.delayed(const Duration(milliseconds: 500), () {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => WillPopScope(onWillPop: () async {
            conversation == null
                ? Get.toNamed(rootRoute)
                : _goToChatDetail(conversation!);
            return false;
          }, child: AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                content: Builder(
                  builder: (context) {
                    return Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                                height: 150,
                                child: Image.asset(
                                    'assets/images/hiring_success.png')),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              "Your Offer to Hire this Helper has been sent to the her/him for Acceptance. Once she/he has accepted your offer, both the Helper's and your profile will be forwarded for Employment Contract processing.\n\nDuring which, Phluid Representative will be contacting you directly at +${user?.countryCallingCode ?? ''} ${user?.phoneNumber ?? '-'} during the chosen time slot to complete the required paperwork.\n\nThank you for Selecting Phluid!",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w200),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            CustomPrimaryButton(
                              text: 'Close',
                              widthButton: 800,
                              onPressed: () => conversation == null
                                  ? Get.toNamed(rootRoute)
                                  : _goToChatDetail(conversation!),
                            ),
                          ]),
                    );
                  },
                ),
              )));
    });
  }

  _goToChatDetail(ZIMKitConversation conversation) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute<void>(
      builder: (context) {
        return ChatDetailsSection(
          conversation: conversation,
        );
      },
    ), (Route<dynamic> route) => false);
  }

  Widget get _getPhoneNumber => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: SizedBox(
              width: 130,
              child: PhoneNumberDropdownItem(
                initialValue: countryName,
                title: StringConst.countryText.tr,
                onValueChanged: (Country country) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      countryCallCode = int.parse(country.dialCode ?? '65');
                    });
                  });
                },
                isCallCode: false,

                ///TODO
                prefix: ConfigsKeyHelper.customerSupportPhoneKey,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: _getTextField(phoneNumberController,
                  StringConst.phoneNumberOnlyText, 1, false,
                  inputType: TextInputType.number)),
        ],
      );

  Widget get _getCreateHiringButton {
    return Column(
      children: [
        CustomPrimaryButton(
          text: 'Yes, Proceed to Hire',
          onPressed: () => _checkValidations(),
          fontSize: 15,
          widthButton: MediaQuery.of(context).size.width,
          heightButton: 47,
        ),
        const SizedBox(
          height: 20,
        ),
        CustomOutlineButton(
          text: 'Cancel',
          onPressed: () =>
              Get.until((route) => route.settings.name == chatDetailPageRoute),
          fontSize: 15,
          widthButton: MediaQuery.of(context).size.width,
          heightButton: 47,
        ),
      ],
    );
  }
}
