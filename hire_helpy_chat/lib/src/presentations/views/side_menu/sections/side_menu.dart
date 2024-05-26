part of '../../views.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key, required this.menuName});

  final String menuName;

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  Map? employerData;
  String basePhotoUrl = '';
  bool isSubMenu = false;
  String mainMenuName = '';
  String country = '';
  String language = '';
  bool logoutLoading = false;

  @override
  void initState() {
    _getEmployerData();
    _getPhotoUrl();
    mainMenuName = widget.menuName;
    super.initState();
  }

  void _getPhotoUrl() async {
    String data = await DBUtils.getEmployerConfigs(DBUtils.stroagePrefix);
    setState(() {
      basePhotoUrl = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployerBloc, EmployerState>(builder: (_, state) {
      return _getSideMenu;
    }, listener: (_, state) {
      if (state is EmployerLogoutLoading) {
        Loading.showLoading(message: StringConst.loadingText);
        Navigator.of(context).pop();
      }
      if (state is EmployerLogoutSuccess) {
        logoutLoading = false;
        if (state.data.data != null) {
          Loading.cancelLoading();
          if (employerData!['google_useruid'] != null) {
            Authentication.signOut(context: context);
          }
          _clearLoginInfo();
        }
      }

      if (state is EmployerLogoutFail) {
        logoutLoading = false;
        Loading.cancelLoading();
        if (state.message != '') {
          showErrorSnackBar(state.message);
          _clearLoginInfo();
        }
      }
    });
  }

  Widget get _getSideMenu => WillPopScope(
      onWillPop: () async {
        print("WILL POP CALLED");
        Get.back();
        return false;
      },
      child: SizedBox(
        width: 280,
        height: MediaQuery.of(context).size.height,
        child: Drawer(
          backgroundColor: Colors.transparent,
          child: ClipRRect(
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0),
                child: _getSideMenuContainer),
          ),
        ),
      ));

  Widget get _getSideMenuContainer {
    return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0)),
          color: AppColors.primaryGrey.withOpacity(0.1),
        ),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height),
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 2.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 40,
                              ),
                              _getMenuItemHeader(),
                              isSubMenu
                                  ? SubMenuItem(
                                      onValueChanged: (bool value) {
                                        setState(() {
                                          isSubMenu = false;
                                          mainMenuName = '';
                                        });
                                      },
                                      mainMenuName: mainMenuName,
                                    )
                                  : _getMainMenuItems
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: _getLanguageAndCountry)
                        ])))));
  }

  get _getMainMenuItems => Column(
        children: [
          employerData == null ? _getLogionRegister : _getAccountLoadingInfo(),

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
          if (employerData != null && !isSubMenu) _getLogoutMenu,
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
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl:
                    '$basePhotoUrl/${employerData!['avatar_s3_filepath']}',
                imageBuilder: (context, imageProvider) => CircleAvatar(
                    backgroundColor: AppColors.white,
                    maxRadius: 25,
                    backgroundImage: imageProvider),
                placeholder: (context, url) => const SizedBox(
                  width: 25,
                  height: 25,
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
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
                          '${employerData!['first_name']} ${employerData!['last_name']}',
                          style: const TextStyle(
                              fontSize: 15, color: AppColors.primaryGrey),
                        ),
                      ),
                      Row(
                        children: [
                          employerData![DBUtils.employerTableName] != null &&
                                  employerData![DBUtils.employerTableName]
                                          ['profile_progress_bar'] ==
                                      3
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

                  //TODO
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
                        '${employerData!['p_coin'].toString()} P.Coins',
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 3),
          employerData![DBUtils.employerTableName] != null &&
                  employerData![DBUtils.employerTableName]
                          ['profile_progress_bar'] ==
                      3
              ? Container()
              : GestureDetector(
                  onTap: () => _gotoCompleteProfile(),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 17),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildProgressBarInfoUser(),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          StringConst.completeYourProfileText,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.yellow,
                          ),
                        ),
                      ],
                    ),
                  )),
        ],
      ),
    );
  }

  //Progress Bar
  Widget _buildProgressBarInfoUser() {
    double completionPercentage = 0.0;
    if (employerData![DBUtils.employerTableName] != null) {
      completionPercentage = employerData![DBUtils.employerTableName]
              ['profile_progress_bar'] *
          1.0;
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
              employerData![DBUtils.employerTableName] != null
                  ? '${(employerData![DBUtils.employerTableName]['profile_progress_bar'] ?? 0) * 30}%'
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
                        height: 1,
                        fontSize: 15,
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
  _goToLogin() {
    //Authentication.signOut(context: context);
    Get.toNamed(signInPageRoute);
  }

  _getEmployerData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      employerData = box.get(DBUtils.employerTableName);
      if (employerData != null) {
        print('data ${employerData!['token']}');
      }
      language = box.get(DBUtils.language) ?? '';
      country = box.get(DBUtils.country) ?? '';
    });
  }

  //Profile Creation
  _gotoCompleteProfile() {
    Get.toNamed(aboutMePageRoute);
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
  createLogOut() {
    showDialog(
      context: context,
      builder: (context) => CustomDialogSimple(
        message: 'Are you sure you want to log out?',
        negativeText: 'Cancel',
        positiveText: 'Log Out',
        onButtonClick: () => _createLogout(),
      ),
    );
  }

  //SignUp
  _goToSignUp() {
    Get.toNamed(registerPageRoute);
  }

  //Click Side Menu
  _clickSideMenu(String name) {
    if (employerData == null) {
      _checkEmptyPage(name);
    } else if (name == widget.menuName) {
      Navigator.pop(context);
    } else {
      switch (name) {
        case StringConst.homeText:
          Get.offAllNamed(rootRoute);
          break;

        case StringConst.starListText:
          Get.toNamed(starListSectionRoute);
          break;

        case StringConst.savedSearchText:
          Get.toNamed(savedSearchPageRoute);
          break;

        case StringConst.contactUsText:
          Get.toNamed(contactUsPageRoute);
          break;

        case StringConst.settingsText:
          Get.toNamed(settingsSectionRoute);
          break;

        case StringConst.referToFriendsText:
          Get.toNamed(refersToFriendPageRoute);
          break;
      }
    }
  }

  _createLogout() {
    if (logoutLoading) {
      return;
    }
    logoutLoading = true;
    final employerBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerLogoutRequestParams params = EmployerLogoutRequestParams(
      token: employerData!['token'],
    );
    employerBloc.add(EmployerLogoutRequested(params: params));
  }

  _clearLoginInfo() {
    DBUtils.clearLoginIn();
    _goToLogin();
  }

  void _checkEmptyPage(String name) {
    superPrint(name);
    switch (name) {
      case StringConst.homeText:
        Get.offAllNamed(rootRoute);
        break;
      case StringConst.phluidCoinText:
        Get.toNamed(nonLoginInfoPageRoute, parameters: {'name': name});
        break;
      case StringConst.rewardTitle:
        Get.toNamed(nonLoginInfoPageRoute, parameters: {'name': name});
        break;
      case StringConst.starListText:
        Get.toNamed(nonLoginInfoPageRoute, parameters: {'name': name});
        break;
      case StringConst.savedSearchText:
        Get.toNamed(nonLoginInfoPageRoute, parameters: {'name': name});
        break;

      case StringConst.contactUsText:
        Get.toNamed(contactUsPageRoute);
        break;
      case StringConst.referToFriendsText:
        Get.toNamed(nonLoginInfoPageRoute, parameters: {'name': name});
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
            SizedBox(
                width: 100,
                child: CountryDropdownItem(
                  prefix: ConfigsKeyHelper.firstTimeLoadCountryKey,
                  title: 'Country',
                  onValueChanged: (String value) {
                    setState(() {
                      country = value;
                    });
                    DBUtils.saveString(country, DBUtils.country);

                    final articleBloc = BlocProvider.of<ArticleBloc>(context);
                    NewsListRequestParams params =
                        NewsListRequestParams(appLocale: country, page: 1);
                    articleBloc.add(NewsListRequested(params: params));

                    final employerBloc = BlocProvider.of<EmployerBloc>(context);
                    employerBloc
                        .add(EmployerUpdateAppLocale(appLocale: country));

                    _requestConfigsChange(false);
                  },
                  initialValue: country,
                  showOnlyIcon: true,
                  topCountries: const [],
                  backgroundColor: Colors.transparent,
                  icon: Iconsax.arrow_circle_down2,
                )),
            SizedBox(
              width: 100,
              child: LanguageDropdownItem(
                prefix: ConfigsKeyHelper.firstTimeLoadLanguageKey,
                title: 'Language',
                onValueChanged: (String value) {
                  setState(() {
                    language = value;
                  });
                  DBUtils.saveString(language, DBUtils.language);
                  LanguageUtils.changeLanguage(language, context);

                  final employerBloc = BlocProvider.of<EmployerBloc>(context);
                  employerBloc
                      .add(EmployerUpdateAppLanguage(language: language));

                  _requestConfigsChange(true);
                },
                initialValue: language,
                topCountries: const [],
                icon: Iconsax.translate,
                isLeadingIcon: true,
                backgroundColor: Colors.transparent,
                hasColouredBorder: false,
              ),
            ),
          ],
        ),
      );

  void _requestConfigsChange(bool isLanguage) {
    if (employerData != null) {
      final employerBloc = BlocProvider.of<EmployerBloc>(context);
      EmployerUpdateConfigsRequestParams params =
          EmployerUpdateConfigsRequestParams(
              token: employerData!['token'],
              path: isLanguage ? 'app_language' : 'app_locale',
              appLocale: isLanguage ? null : country,
              preferredLanguage: isLanguage ? language : null);
      employerBloc.add(EmployerUpdateConfigsRequested(params: params));
    }
  }
}
