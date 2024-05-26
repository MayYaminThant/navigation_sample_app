part of '../../views.dart';

class VerifiedSuccessSection extends StatefulWidget {
  const VerifiedSuccessSection({Key? key}) : super(key: key);

  @override
  State<VerifiedSuccessSection> createState() => _VerifiedSuccessSectionState();
}

class _VerifiedSuccessSectionState extends State<VerifiedSuccessSection> {
  Map? employerData;
  bool isSocial = false;

  @override
  void initState() {
    super.initState();
    if (Get.parameters.isNotEmpty) {
      isSocial = Get.parameters['type'] != null ? true : false;
    }
    _getEmployerData();
  }

  _getEmployerData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      employerData = box.get(DBUtils.employerTableName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _getVerifyScaffold;
  }

  Widget get _getVerifyScaffold {
    return WillPopScope(
        onWillPop: () async {
          Get.toNamed(rootRoute);
          return false;
        },
        child: Scaffold(body: _getVerifyContainer));
  }

  //Stack with background image
  Widget get _getVerifyContainer {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/no-image-bg.png'),
              fit: BoxFit.cover)),
      child: _getVerifiedColumn,
    );
  }

  Widget get _getVerifiedColumn {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: 700,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/gif/congratulations.gif',
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  SizedBox(
                    height: 73,
                    width: 73,
                    child: Image.asset('assets/icons/checkmark.png'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    StringConst.congratulationText,
                    style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: SizedBox(
                      width: 320,
                      child: Text(
                        '${StringConst.verifiedText}\n${StringConst.verified2Text}',
                        style: const TextStyle(
                            color: AppColors.primaryGrey,
                            fontSize: 16,
                            height: 1.5),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width - 60,
                        child: CustomPrimaryButton(
                          text: StringConst.referAFriendText,
                          onPressed: () => shareInviteLink(),
                        )),
                  ),
                  _getRegisterLater
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  //Register Later
  Widget get _getRegisterLater {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
          width: MediaQuery.of(context).size.width - 60,
          height: Sizes.button47,
          child: CustomOutlineButton(
            text: StringConst.skipForNowText,
            onPressed: () => Get.offAllNamed(homePageRoute),
          )),
    );
  }

  Future<void> shareInviteLink() async {
    String link = (await _getInviteLink()).toString();
    await FlutterShare.share(
        title: kMaterialAppTitle,
        text: StringConst.letsConnectOnDHText,
        linkUrl: link,
        chooserTitle: kMaterialAppTitle);
  }

  _getInviteLink() async {
    return await ShortLink.createShortLink(
        employerData!['login_name'], kShortLinkInvite);
  }
}
