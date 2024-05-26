part of '../../views.dart';

class AccountCheckSection extends StatefulWidget {
  const AccountCheckSection({super.key});

  @override
  State<AccountCheckSection> createState() => _AccountCheckSectionState();
}

class _AccountCheckSectionState extends State<AccountCheckSection> {
  final TextEditingController emailController = TextEditingController();
  String resetType = '';
  Map? candidateData;

  @override
  void initState() {
    _getCandidateData();
    super.initState();
  }

  _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      candidateData = box.get('forget_user');
    });
    print('data $candidateData');
  }

  @override
  Widget build(BuildContext context) {
    return _getAccountCheckScaffold;
  }

  Widget get _getAccountCheckScaffold {
    return Scaffold(
      body: _getAccountCheckContainer,
    );
  }

  //Stack with background image
  Widget get _getAccountCheckContainer {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/no-image-bg.png'),
                  fit: BoxFit.cover)),
          child: candidateData != null ? _getAccountCheckColumn : Container(),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: SizedBox(
                width: 330,
                child: CustomPrimaryButton(
                  text: StringConst.sendCodeText,
                  onPressed: () => Get.toNamed(forgotOTPPageRoute, parameters: {
                    'method': resetType != 'email' ? 'sms' : 'email'
                  }),
                )),
          ),
        )
      ],
    );
  }

  Widget get _getAccountCheckColumn {
    return Column(
      children: [
        const SizedBox(
          height: 60,
        ),
        _getAccountCheckHeader,
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
          child: Text(
            '${StringConst.accountFoundTitleText} ${candidateData!['login_name']}',
            style: const TextStyle(color: AppColors.primaryGrey, fontSize: 15),
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const AccountInfo(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
          child: Text(
            StringConst.chooseMenuTitle,
            style: TextStyle(color: AppColors.primaryGrey, fontSize: 15),
            textAlign: TextAlign.start,
          ),
        ),
        _getSendToMenu(
            title: StringConst.sendToEmailAddressText,
            text: candidateData!['email'],
            value: 'email'),
        const SizedBox(
          height: 30,
        ),
        _getSendToMenu(
            title: StringConst.sendToPhoneNumberText,
            text: candidateData!['phone_number'] != null
                ? '+${candidateData!['country_calling_code'].toString()}${candidateData!['phone_number'].toString()}'
                : '',
            value: 'phone')
      ],
    );
  }

  //Forgot Password
  Widget get _getAccountCheckHeader {
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
        const Text(
          StringConst.forgetPasswordText,
          textAlign: TextAlign.center,
          style: TextStyle(
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

  //Send To Email Address
  _getSendToMenu(
      {required String title, required String text, required String value}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          resetType = value;
        });
      },
      child: Container(
          width: MediaQuery.of(context).size.width - 40,
          height: 65,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
              color: AppColors.cardColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.0)),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                    color: AppColors.cardColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.0)),
                child: resetType == value
                    ? Container(
                        width: 12,
                        height: 12,
                        margin: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.circular(12.0)),
                      )
                    : const SizedBox.shrink(),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style:
                        const TextStyle(color: AppColors.white, fontSize: 12.0),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    text,
                    style: const TextStyle(
                        color: AppColors.primaryGrey, fontSize: 12.0),
                  )
                ],
              )
            ],
          )),
    );
  }
}
