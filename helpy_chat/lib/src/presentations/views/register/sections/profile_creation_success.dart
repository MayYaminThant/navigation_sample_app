part of '../../views.dart';

class ProfileCreationSuccessSection extends StatefulWidget {
  const ProfileCreationSuccessSection({Key? key}) : super(key: key);

  @override
  State<ProfileCreationSuccessSection> createState() =>
      _ProfileCreationSuccessSectionState();
}

class _ProfileCreationSuccessSectionState
    extends State<ProfileCreationSuccessSection> {
  @override
  Widget build(BuildContext context) {
    return _getProfileCreationSuccessScaffold;
  }

  Widget get _getProfileCreationSuccessScaffold {
    return Scaffold(
      body: _getProfileCreationSuccessContainer,
    );
  }

  //Stack with background image
  Widget get _getProfileCreationSuccessContainer {
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: SizedBox(
                      width: 320,
                      child: Text(
                        StringConst.profileCreationSuccessText.tr,
                        style: const TextStyle(
                          color: AppColors.primaryGrey,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
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
