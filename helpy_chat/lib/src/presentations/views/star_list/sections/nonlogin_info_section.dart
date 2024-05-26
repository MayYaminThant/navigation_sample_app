part of '../../views.dart';

class NonLoginInfoSection extends StatefulWidget {
  const NonLoginInfoSection({super.key});

  @override
  State<NonLoginInfoSection> createState() => _NonLoginInfoSectionState();
}

class _NonLoginInfoSectionState extends State<NonLoginInfoSection> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String name = '';

  @override
  void initState() {
    super.initState();
    if (Get.parameters.isNotEmpty) {
      name = Get.parameters['name'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return _getNonLoginInfoSection;
  }

  BackgroundScaffold get _getNonLoginInfoSection {
    return BackgroundScaffold(
        scaffold: Scaffold(
      key: _scaffoldKey,
      appBar: _getAppBar,
      drawer: SideMenu(
        menuName: name,
      ),
      backgroundColor: Colors.transparent,
      drawerScrimColor: Colors.transparent,
      body: _getInfoMessageContainer(),
      bottomNavigationBar: _getSearchNowButton,
    ));
  }

  AppBar get _getAppBar {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: InkWell(
            onTap: () => _scaffoldKey.currentState!.openDrawer(),
            child: Image.asset("assets/icons/menu.png")),
      ),
      leadingWidth: 52,
      title: Text(
        name.tr,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      elevation: 0.0,
      titleSpacing: 0.0,
      centerTitle: true,
    );
  }

  _getInfoMessageContainer() {
    switch (name) {
      case StringConst.starListText:
        return _getStarInfoMessageContainer();

      case StringConst.savedSearchText:
        return _getSavedSearchInfoMessageContainer();

      case StringConst.phluidCoinText:
        return _getVouchersInfoMessageContainer();

      case StringConst.chatTitle:
        return _getChatContainer;
      case StringConst.chatRequestText:
        return _getchatRequestContainer;
      case StringConst.myAccountText:
        return _getmyAccountContainer;
      case StringConst.profileDetailsText:
        return _getmyAccountContainer;
      case StringConst.rewardTitle:
        return _getrewardTitleContainer;

      case StringConst.referToFriendsText:
        return _getReferToFriendsInfoMessageContainer();
    }
  }

  _getStarInfoMessageContainer() {
    return const EmptyMessage(
      title: 'Opps! No Star List yet...',
      image: 'assets/images/empty-result.png',
      description: Text.rich(
        TextSpan(
          children: [
            TextSpan(
                text:
                    'Discover your dream offers and keep them at your fingertips! Simply log in or register to save your top picks in the star list. With a limit of 5 offers per account, you can easily search and compare your favorites again and again.',
                style: TextStyle(
                    fontSize: 14, color: AppColors.primaryGrey, height: 2)),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget get _getChatContainer => EmptyMessage(
        title: StringConst.noChatHistory,
        image: 'assets/images/empty-chat.png',
        description: Column(
          children: <Widget>[
            Text(StringConst.diveIntoCommunity.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.primaryGrey,
                  height: 2,
                )),
            const SizedBox(height: 23),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                      text:
                          'By registering, you can quickly dive into our GLOBAL Domestic Helper community, get connected to potential ',
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryGrey,
                          height: 2)),
                  TextSpan(
                      text: 'Employers WORLDWIDE',
                      style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.offNamed(registerPageRoute)),
                  const TextSpan(
                      text: ', and ',
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryGrey,
                          height: 2)),
                  TextSpan(
                      text: 'DIRECT CHAT',
                      style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.offNamed(registerPageRoute)),
                  const TextSpan(
                      text: ' them. It’s that simple.  Join us!',
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryGrey,
                          height: 2)),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );

  Widget get _getchatRequestContainer => const EmptyMessage(
        title: 'You have no chat Request...',
        image: 'assets/images/empty-chat.png',
        description: Text(
            "Ready to dive into our  Phluid Community? By logging in or registering, you can quickly dive into our community, get connected to potential employers, and talk to them. It’s simple and easy.  Just join us now!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.primaryGrey,
              height: 2,
            )),
      );

  Widget get _getmyAccountContainer => EmptyMessage(
        title: 'You have no Account now',
        image: 'assets/images/profile-desk.png',
        description: Column(
          children: <Widget>[
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                      text:
                          'By creating a Phluid Account and Strong Profile, you will be recommended by Phluid AI engine to ',
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryGrey,
                          height: 2)),
                  TextSpan(
                      text: 'Employers WORLDWIDE.',
                      style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.offNamed(registerPageRoute)),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 23),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                      text: 'A Phluid Account will also enable you to ',
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryGrey,
                          height: 2)),
                  TextSpan(
                      text: 'recommend friends',
                      style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.offNamed(registerPageRoute)),
                  const TextSpan(
                      text: ' into the Domestic Helper Industry and ',
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryGrey,
                          height: 2)),
                  TextSpan(
                      text: 'Earn Phluid Coins',
                      style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.offNamed(registerPageRoute)),
                  const TextSpan(
                      text: ' and get ',
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryGrey,
                          height: 2)),
                  TextSpan(
                      text: 'FREE Rewards.',
                      style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.offNamed(registerPageRoute)),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );

  Widget get _getrewardTitleContainer => const EmptyMessage(
        title: 'There are no rewards yet...',
        image: 'assets/images/no_reward.png',
        description: Text(
            "Ready to claim the wonderful rewards? When your friends get to the app by installing and registering through your link, claim your coins and get your rewards. Just remember to log in and watch those shiny treasures fill your account!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.primaryGrey,
              height: 2,
            )),
      );

  _getSavedSearchInfoMessageContainer() {
    return const EmptyMessage(
      title: 'Opps! No Saved Search...',
      image: 'assets/images/empty-result.png',
      description: Text.rich(
        TextSpan(
          children: [
            TextSpan(
                text:
                    "Say goodbye to repeated searches! By logging in or registering, you can easily save your previous searches and access them instantly. Join us today and streamline your search experience.",
                style: TextStyle(
                    fontSize: 14, color: AppColors.primaryGrey, height: 2)),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  _getVouchersInfoMessageContainer() {
    return const EmptyMessage(
      title: 'You Don’t Have Coins Yet...',
      image: 'assets/images/empty-coins.png',
      description: Text.rich(
        TextSpan(
          children: [
            TextSpan(
                text:
                    "Once your friends have successfully installed the app and registered through the link you shared, a magical moment awaits - you can finally unlock the treasure trove of coins and bask in the glory of your rewards!",
                style: TextStyle(
                    fontSize: 14, color: AppColors.primaryGrey, height: 2)),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  //Search Now Button
  Widget get _getSearchNowButton {
    return SizedBox(
      height: 150,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: Sizes.padding20,
                right: Sizes.padding20,
                bottom: Sizes.padding20),
            child: SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: Sizes.button47,
                child: CustomPrimaryButton(
                  text: StringConst.gotoLoginText,
                  onPressed: () => Get.offNamed(signInPageRoute),
                )),
          ),
          _getTextWithAction
        ],
      ),
    );
  }

  Widget get _getTextWithAction {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
                text: StringConst.dontHaveAccount.tr,
                style: const TextStyle(color: AppColors.primaryGrey)),
            TextSpan(
                text: StringConst.register.tr,
                style: const TextStyle(
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.w700),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Get.offNamed(registerPageRoute)),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  _getReferToFriendsInfoMessageContainer() {
    return const EmptyMessage(
      title: 'You Don’t Have Coins Yet...',
      image: 'assets/images/empty-coins.png',
      description: Text.rich(
        TextSpan(
          children: [
            TextSpan(
                text:
                    "Unleash the power of friendship! When your friends get to the app by installing and registering through your link, claim your coins. Just remember to log in and watch those shiny treasures fill your account!",
                style: TextStyle(
                    fontSize: 14, color: AppColors.primaryGrey, height: 2)),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
