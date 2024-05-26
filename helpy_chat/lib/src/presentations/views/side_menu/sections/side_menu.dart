part of '../../views.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key, required this.menuName});
  final String menuName;

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  Map? candidateData;
  String basePhotoUrl = '';
  bool isSubMenu = false;
  String mainMenuName = '';
  String country = '';
  ConfigLanguage language =
      const ConfigLanguage(language: "English", languageName: "English");
  List<ConfigLanguage> languageList = [];

  @override
  void initState() {
    _initLoad();
    super.initState();
  }

  Future<void> _initLoad() async {
    await _getCandidateData();
    await _getPhotoUrl();
    mainMenuName = widget.menuName;
  }

  Future<void> _getPhotoUrl() async {
    String? data = await DBUtils.getCandidateConfigs(DBUtils.stroagePrefix);
    if (data != null) {
      setState(() {
        basePhotoUrl = data;
      });
    }
  }

  Future<void> _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    final lan = box.get(DBUtils.language);
    List<ConfigLanguage> dataList = List<ConfigLanguage>.from(
        (await DBUtils.getKeyDataList(ConfigsKeyHelper.articleLanguageKey))
            .map((e) => ConfigLanguageModel.fromJson(e)));
    setState(() {
      languageList.addAll(dataList);
      candidateData = box.get(DBUtils.candidateTableName);
      language = languageList.singleWhere((element) => element.language == lan,
          orElse: () => const ConfigLanguage(
              language: "English", languageName: "English"));
      country = box.get(DBUtils.country) ?? 'Singapore';
    });
  }

  @override
  Widget build(BuildContext context) {
    return _getSideMenu;
  }

  Widget get _getSideMenu => SizedBox(
        width: 280,
        height: MediaQuery.of(context).size.height,
        child: Drawer(
          backgroundColor: Colors.transparent,
          child: ClipRRect(
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: _getSideMenuContainer),
          ),
        ),
      );

  Widget get _getSideMenuContainer {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0)),
            color: AppColors.primaryGrey.withOpacity(0.2),
          ),
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              _getMenuItemHeader(),
              SizedBox(
                  height: MediaQuery.of(context).size.height - 120,
                  child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: isSubMenu
                          ? SubMenuItem(
                              onValueChanged: (bool value) {
                                setState(() {
                                  isSubMenu = false;
                                  mainMenuName = '';
                                });
                              },
                              mainMenuName: mainMenuName,
                            )
                          : _getMainMenuItems))
            ],
          ),
        ),

        //Language & Country
        if (!isSubMenu && MediaQuery.of(context).size.height > 820)
          Positioned(
              bottom: 10, right: 20, left: 20, child: _getLanguageAndCountry)
      ],
    );
  }

  Widget get _getMainMenuItems => Column(
        children: [
          candidateData == null ? _getLogionRegister : _getAccountLoadingInfo(),

          //Home
          _getMenuItems(Iconsax.home, StringConst.homeText, false),

          //Chat Setting
          _getMenuItems(Iconsax.message4, StringConst.chatSettingText, true),

          //Account Setting
          _getMenuItems(
              Iconsax.setting_2, StringConst.accountSettingText, true),

          const MenuDivider(),

          //Star List
          _getMenuItems(Iconsax.star_14, StringConst.starListText, false),
          //Saved Search
          _getMenuItems(Iconsax.save_2, StringConst.savedSearchText,
              false), //Iconsax.save_21

          //Chat
          //Phluid Coins
          _getPhluidCoinMenuItems(
              StringConst.coinsAndRewardText), // Iconsax.send_25
          const MenuDivider(),

          _getMenuItems(
              Iconsax.card_send, StringConst.referToFriendsText, false),
          //Contact Us
          _getMenuItems(Iconsax.send_24, StringConst.contactUsText, false),

          //Logout
          candidateData != null && !isSubMenu ? _getLogoutMenu : Container(),

          //Language & Country
          !isSubMenu && MediaQuery.of(context).size.height < 820
              ? _getLanguageAndCountry
              : Container()
        ],
      );

  //Menu Header
  _getMenuItemHeader() {
    return SizedBox(
      height: isSubMenu ? 60 : 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            SizedBox(
              width: 60,
              height: 40,
              child: Image.asset('assets/images/logo.png'),
            ),
            const SizedBox(
              width: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                kMaterialAppTitle,
                style: TextStyle(
                    color: Color(0xffC4D9FD),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            )
          ]),
        ],
      ),
    );
  }

  Widget _getAccountLoadingInfo() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(vertical: 13.0),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          color: AppColors.black.withOpacity(0.15)),
      width: MediaQuery.of(context).size.width - 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomImageView(
                  width: 45,
                  height: 45,
                  fit: BoxFit.cover,
                  image:
                      '$basePhotoUrl/${candidateData!['avatar_s3_filepath']}',
                  color: AppColors.white,
                  radius: BorderRadius.circular(25)),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: 120,
                          child: Text(
                            '${candidateData!['first_name']} ${candidateData!['last_name']}',
                            style: const TextStyle(
                                fontSize: 15, color: AppColors.primaryGrey),
                          )),
                      Row(
                        children: [
                          candidateData![DBUtils.candidateTableName] != null &&
                                  candidateData![DBUtils.candidateTableName]
                                          ['profile_progress_bar'] ==
                                      5
                              ? Container(
                                  width: 21,
                                  height: 21,
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: AppColors.brandBlue),
                                  child: Image.asset(
                                    'assets/icons/check.png',
                                    color: Colors.black.withOpacity(0.4),
                                  ),
                                )
                              : Container(),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: SvgPicture.asset('assets/svg/coin.svg',
                            // ignore: deprecated_member_use
                            color: AppColors.primaryColor),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${candidateData!['p_coin'].toString()} P.Coins',
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          candidateData![DBUtils.candidateTableName] != null &&
                  candidateData![DBUtils.candidateTableName]
                          ['profile_progress_bar'] ==
                      5
              ? Container()
              : GestureDetector(
                  onTap: () => _gotoCompleteProfile(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildProgressBarInfoUser(),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        StringConst.completeYourProfileText.tr,
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColors.yellow,
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  //Progress Bar
  Widget _buildProgressBarInfoUser() {
    double completionPercentage = 0.0;
    if (candidateData![DBUtils.candidateTableName] != null) {
      completionPercentage = candidateData![DBUtils.candidateTableName]
              ['profile_progress_bar'] *
          0.5;
    }
    return Container(
      width: 200,
      height: 13,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Container(
            width: 80 * completionPercentage,
            decoration: BoxDecoration(
              color: AppColors.yellow,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Center(
            child: Text(
              candidateData![DBUtils.candidateTableName] != null
                  ? '${(candidateData![DBUtils.candidateTableName]['profile_progress_bar'] ?? 0) * 20}%'
                  : '0%',
              style: const TextStyle(fontSize: 10, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  //Menu Items
  Widget _getMenuItems(IconData icon, String name, bool isMoreSetting) =>
      InkWell(
          onTap: () => isMoreSetting
              ? setState(() {
                  isSubMenu = true;
                  mainMenuName = name;
                })
              : _clickSideMenu(name),
          child: SizedBox(
            width: double.infinity,
            child: MenuItem(
              icon: icon,
              name: name,
              iconColor: name == widget.menuName
                  ? AppColors.primaryColor
                  : AppColors.white,
              textColor: name == widget.menuName
                  ? AppColors.primaryColor
                  : AppColors.primaryGrey,
              isMoreSetting: isMoreSetting,
            ),
          ));

  //Menu Items
  Widget _getPhluidCoinMenuItems(String name) => GestureDetector(
        onTap: () => setState(() {
          isSubMenu = true;
          mainMenuName = name;
        }),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 26,
                    height: 26,
                    child: SvgPicture.asset(
                      'assets/svg/coin.svg',
                      // ignore: deprecated_member_use
                      color: name == widget.menuName
                          ? AppColors.primaryColor
                          : AppColors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    name.tr,
                    style: TextStyle(
                        fontSize: 15,
                        height: 1,
                        color: name == widget.menuName
                            ? AppColors.primaryColor
                            : AppColors.primaryGrey),
                  ),
                ],
              ),
              _getForwardIcon(name)
            ],
          ),
        ),
      );

  //Login
  void _goToLogin() {
    //Authentication.signOut(context: context);
    Get.offAllNamed(signInPageRoute);
  }

  //Profile Creation
  void _gotoCompleteProfile() {
    Get.offNamed(aboutMePageRoute);
  }

  //Login & SignUp
  Widget get _getLogionRegister => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              children: [
                SizedBox(
                  width: 26,
                  height: 26,
                  child: Image.asset(
                    'assets/icons/profilecircle.png',
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () => _goToLogin(),
                  child: Text(
                    StringConst.loginText.tr,
                    style: const TextStyle(
                        fontSize: 15, color: AppColors.primaryGrey),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  height: 20,
                  width: 1,
                  color: AppColors.primaryGrey,
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () => _goToSignUp(),
                  child: Text(
                    StringConst.signUpText.tr,
                    style: const TextStyle(
                        fontSize: 15, color: AppColors.primaryGrey),
                  ),
                ),
              ],
            ),
          ),
          const MenuDivider()
        ],
      );

  //Logout Create
  bool loadingLogout = false;
  void createLogOut() {
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) =>
                  BlocConsumer<CandidateBloc, CandidateState>(
                builder: (context, state) => CustomDialogSimple(
                  message: StringConst.logOutConfirm,
                  negativeText: 'Cancel',
                  positiveText: 'Log Out',
                  onButtonClick: loadingLogout ? null : () => _createLogout(),
                ),
                listener: (context, state) {
                  if (state is CandidateLogoutLoading) {
                    Loading.showLoading(message: StringConst.loadingText);
                    changeLoading(true);
                  }
                  if (state is CandidateLogoutSuccess) {
                    Loading.cancelLoading();
                    changeLoading(false);
                    if (state.data.data != null) {
                      if (candidateData!['google_useruid'] != null) {
                        Authentication.signOut(context: context);
                      }
                      _clearLoginInfo();
                    }
                  }
                  if (state is CandidateLogoutFail) {
                    Loading.cancelLoading();
                    changeLoading(false);
                    if (state.message != '') {
                      showErrorSnackBar(state.message);
                      _clearLoginInfo();
                    }
                  }
                },
              ),
            ));
  }

  void changeLoading(bool value) {
    setState(() {
      loadingLogout = value;
    });
  }

  //SignUp
  void _goToSignUp() {
    Get.toNamed(registerPageRoute);
  }

  //Click Side Menu
  void _clickSideMenu(String name) {
    if (candidateData == null) {
      _checkEmptyPage(name);
    } else if (name == widget.menuName) {
      Navigator.pop(context);
    } else {
      switch (name) {
        case StringConst.homeText:
          Get.offAllNamed(rootRoute);
          break;

        case StringConst.starListText:
          Get.offNamed(starListSectionRoute);
          break;

        case StringConst.savedSearchText:
          Get.offNamed(savedSearchPageRoute);
          break;

        case StringConst.contactUsText:
          Get.offNamed(contactUsPageRoute);
          break;

        case StringConst.settingsText:
          Get.offNamed(settingsSectionRoute);
          break;

        case StringConst.referToFriendsText:
          Get.offNamed(refersToFriendPageRoute);
          break;

        default:
          Get.toNamed(signInPageRoute);
          break;
      }
    }
  }

  void _createLogout() {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateLogoutRequestParams params = CandidateLogoutRequestParams(
      token: candidateData!['token'],
    );
    candidateBloc.add(CandidateLogoutRequested(params: params));
  }

  void _clearLoginInfo() {
    DBUtils.clearLoginIn();
    _goToLogin();
  }

  void _checkEmptyPage(String name) {
    switch (name) {
      case StringConst.homeText:
        Get.offAllNamed(rootRoute);
        break;

      case StringConst.starListText:
        Get.offNamed(nonLoginInfoPageRoute, parameters: {'name': name});
        break;

      case StringConst.savedSearchText:
        Get.offNamed(nonLoginInfoPageRoute, parameters: {'name': name});
        break;

      case StringConst.contactUsText:
        Get.offNamed(contactUsPageRoute);
        break;
      case StringConst.referToFriendsText:
        Get.offNamed(nonLoginInfoPageRoute, parameters: {'name': name});
        break;
    }
  }

  //Forward Menu Icon
  _getForwardIcon(String name) => Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color:
            name == widget.menuName ? AppColors.primaryColor : AppColors.white,
      );

  get _getLogoutMenu => GestureDetector(
        onTap: () => createLogOut(),
        child: const MenuItem(
          icon: Iconsax.logout,
          name: StringConst.logoutText,
          iconColor: AppColors.red,
          textColor: AppColors.red,
          isMoreSetting: false,
        ),
      );

  //Language Change
  get _getLanguageAndCountry => Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 1,
                child: CountryDropdownItem(
                  prefix: ConfigsKeyHelper.firstTimeLoadCountryKey,
                  title: StringConst.countryText,
                  onValueChanged: (String value) {
                    setState(() {
                      country = value;
                    });
                    DBUtils.saveString(country, DBUtils.country);

                    final candidateBloc =
                        BlocProvider.of<CandidateBloc>(context);
                    candidateBloc
                        .add(CandidateUpdateAppLocale(appLocale: country));

                    _requestConfigsChange(false);
                    _requestArticleList();
                    _requestNewsList();
                  },
                  initialValue: country,
                  showOnlyIcon: true,
                  topCountries: const [],
                  backgroundColor: Colors.transparent,
                  icon: Iconsax.arrow_circle_down2,
                )),
            Flexible(
              flex: 1,
              child: Center(
                child: LanguageDropdownItem(
                  prefix: ConfigsKeyHelper.firstTimeLoadLanguageKey,
                  title: 'Language',
                  onValueChanged: (value) {
                    final langValue = languageList.singleWhere(
                        (element) => element.language == value,
                        orElse: () => const ConfigLanguage(
                            language: "English", languageName: "English"));
                    setState(() {
                      language = langValue;
                    });
                    final candidateBloc =
                        BlocProvider.of<CandidateBloc>(context);
                    candidateBloc.add(CandidateUpdateAppLanguage(
                        language: language.language ?? ''));
                    DBUtils.saveString(
                        "${language.language}", DBUtils.language);
                    LanguageUtils.changeLanguage("${language.language}");
                    _requestConfigsChange(true);
                    _requestArticleList();
                    _requestNewsList();
                    _requestFAQList();
                  },
                  initialValue: "${language.language}",
                  topCountries: const [],
                  icon: Iconsax.translate,
                  isLeadingIcon: true,
                  isBorderGradient: false,
                  backgroundColor: AppColors.white.withOpacity(0.1),
                ),
              ),
            ),
          ],
        ),
      );

  void _requestConfigsChange(bool isLanguage) {
    if (candidateData != null) {
      final candidateBloc = BlocProvider.of<CandidateBloc>(context);
      CandidateUpdateConfigsRequestParams params =
          CandidateUpdateConfigsRequestParams(
              token: candidateData!['token'],
              path: isLanguage ? 'app_language' : 'app_locale',
              appLocale: isLanguage ? null : country,
              preferredLanguage: isLanguage ? language.language : null);
      candidateBloc.add(CandidateUpdateConfigsRequested(params: params));
    }
  }

  void _requestArticleList() {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    ArticlesListRequestParams params =
        ArticlesListRequestParams(language: country, sortBy: "latest", page: 1);
    articleBloc.add(ArticlesListRequested(params: params));
  }

  void _requestNewsList() {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    NewsListRequestParams params =
        NewsListRequestParams(appLocale: country, page: 1);
    articleBloc.add(NewsListRequested(params: params));
  }

  void _requestFAQList() {
    final faqBloc = BlocProvider.of<FaqBloc>(context);
    FaqRequestParams params =
        FaqRequestParams(language: language.language, page: 1, keyword: "");
    faqBloc.add(FaqsRequested(params: params));
  }
}
