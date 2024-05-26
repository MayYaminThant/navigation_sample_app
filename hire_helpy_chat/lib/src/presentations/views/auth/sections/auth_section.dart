part of '../../views.dart';

class AuthSection extends StatefulWidget {
  const AuthSection({super.key});

  @override
  State<AuthSection> createState() => _AuthSectionState();
}

class _AuthSectionState extends State<AuthSection>
    with TickerProviderStateMixin {
  late TabController tabController;
  int tabIndex = 0;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  void disponse() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _getAuthScaffold;
  }

  Widget get _getAuthScaffold {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/no-image-bg.png'),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _getAuthContainer,
      ),
    );
  }

  //Phluid Logo with image and titles
  Widget get _getAuthContainer {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(
          height: 60,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SizedBox(
            height: 140,
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 40.0),
          child: Text(
            StringConst.registerSignInTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
        const Text(
          StringConst.registerSignInSubTitle,
          style: TextStyle(color: AppColors.primaryGrey, fontSize: 15),
        ),
        const SizedBox(
          height: 20,
        ),
        _getRegisterAccount,
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: ContinueWithWidget(),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        _getTextWithAction
      ],
    );
  }

  //Register Account Button
  Widget get _getRegisterAccount {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
          width: 330,
          height: Sizes.button47,
          child: CustomPrimaryButton(
            text: StringConst.getStartedText,
            onPressed: () => Get.toNamed(registerPageRoute),
          )),
    );
  }

  //Register Later
  Widget get _getRegisterLater {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
          width: 330,
          height: Sizes.button47,
          child: CustomOutlineButton(
            text: StringConst.registerLaterText,
            onPressed: () => Get.offAllNamed(homePageRoute),
          )),
    );
  }

  //Sign In
  Widget get _getTextWithAction {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Text.rich(
        TextSpan(
          children: [
            const TextSpan(
                text: 'Already have an account?   ',
                style: TextStyle(color: AppColors.primaryGrey)),
            TextSpan(
                text: 'Sign In',
                style: const TextStyle(
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.w700),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Get.offNamed(signInPageRoute)),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
