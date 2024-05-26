part of '../../views.dart';

class RecoveredSuccessSection extends StatefulWidget {
  const RecoveredSuccessSection({Key? key}) : super(key: key);

  @override
  State<RecoveredSuccessSection> createState() =>
      _RecoveredSuccessSectionState();
}

class _RecoveredSuccessSectionState extends State<RecoveredSuccessSection> {
  @override
  Widget build(BuildContext context) {
    return _getVerifyScaffold;
  }

  Widget get _getVerifyScaffold {
    return Scaffold(
      body: WillPopScope(onWillPop: () async => false, child: _getVerifyContainer),
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
    return Column(children: [
      Expanded(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 25.0),
            child: HeroImage(
                imagePath: 'assets/images/password_reset_success.png')),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              StringConst.congratulationsText,
              style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            )),
        const Text(
          StringConst.recoverPassword,
          style: TextStyle(color: AppColors.white, fontSize: 16),
          textAlign: TextAlign.center,
        )
      ])),
      _getSignInButton
    ]);
  }

  Widget get _getSignInButton => Padding(
      padding: const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        CustomPrimaryButton(
          text: StringConst.backToSignInText,
          onPressed: () => Get.offAllNamed(signInPageRoute),
        )
      ]));
}
