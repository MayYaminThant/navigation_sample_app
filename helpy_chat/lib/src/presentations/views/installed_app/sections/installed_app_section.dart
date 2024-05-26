part of '../../views.dart';

class InstalledAppSection extends StatefulWidget {
  const InstalledAppSection({Key? key}) : super(key: key);

  @override
  State<InstalledAppSection> createState() => _InstalledAppSectionState();
}

class _InstalledAppSectionState extends State<InstalledAppSection> {
  Map? candidateData;
  bool isSocial = false;

  @override
  void initState() {
    super.initState();
    if (Get.parameters.isNotEmpty) {
      isSocial = Get.parameters['type'] != null ? true : false;
    }
    _getCandidateData();
  }

  Future<void> _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      candidateData = box.get(DBUtils.candidateTableName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _getVerifyScaffold;
  }

  Widget get _getVerifyScaffold {
    return Scaffold(
      body: _getVerifyContainer,
    );
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
                    StringConst.congratulationText.tr,
                    style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        children: [
                          TextSpan(
                            text:
                                'You are already app installed. Refer our app to your friends to earn ',
                            style: TextStyle(
                                color: AppColors.primaryGrey,
                                fontSize: 16,
                                height: 2),
                          ),
                          TextSpan(
                              text: 'phluid coins',
                              style: TextStyle(
                                  color: AppColors.secondaryColor,
                                  fontSize: 16,
                                  height: 2)),
                          TextSpan(
                            text: ".",
                            style: TextStyle(
                                color: AppColors.primaryGrey,
                                fontSize: 16,
                                height: 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width - 60,
                        child: CustomPrimaryButton(
                          text: StringConst.backToHomeText,
                          onPressed: () => Get.offAllNamed(rootRoute),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
