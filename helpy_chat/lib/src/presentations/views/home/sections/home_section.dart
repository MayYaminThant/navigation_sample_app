part of '../../views.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({super.key});

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map? candidateData;
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  String status = '';
  String avaliblityStatus = '';
  String? timeStamp;

  bool isMaintenanceEnabled = false;
  String appMaintenanceMessage = "";
  String appMaintenancebkColor = "";
  bool isInMaintenanceTime = false;

  bool isArticleCampaignEnabled = false;
  String campaignMessage = "";
  String campaignbkColor = "";

  DateTime now = DateTime.now();

  @override
  void initState() {
    initLoad();
    WidgetsBinding.instance.addObserver(this);
    showDialogFromFirebase();
    super.initState();
  }

  Future<void> initLoad() async {
    _checkForResume();
    await _getCandidateData();
    _requestCandidateConfigs();
    _initializeAnimation();
  }

  void _checkForResume() {
    Future.delayed(Duration.zero, () {
      final loginResume = LoginResume();
      loginResume.resumeState();
    });
  }

  void _campaignCheck(bool value) {
    setState(() {
      isArticleCampaignEnabled = value;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _requestCandidateConfigs();
    }
  }

  void _requestCandidateConfigs() {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateConfigsRequestParams params =
        CandidateConfigsRequestParams(lastTimestamp: null);
    candidateBloc.add(CandidateConfigsRequested(params: params));
  }

  Future<void> _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    timeStamp = box.get(DBUtils.lastTimeStamp);
    Map? data = box.get(DBUtils.candidateTableName);
    if (data == null) {
      await _showJoinModal();
    } else {
      setState(() {
        candidateData = data;
      });
    }
  }

  void _initializeAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  Future<void> _showJoinModal() async {
    await Future.delayed(const Duration(milliseconds: 100), () {
      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            _animationController.forward(from: 0.0);
            return SlideTransition(
              position: _animation,
              child: const RegisterEnjoyPopUp(),
            );
          },
        );
      }
    });
  }

  Future<bool> confirmAppExit() async {
    final status = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogSimple(
          message: 'Are you sure you want to leave?',
          negativeText: 'Cancel',
          positiveText: 'Leave',
          onButtonClick: () => Navigator.of(context).pop(true),
        );
      },
    );
    return "$status" == 'true';
  }

  @override
  void dispose() {
    _animationController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _homeScaffold;
  }

  Widget get _homeScaffold => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BackgroundScaffold(
            scaffold: Scaffold(
                key: _scaffoldKey,
                appBar: _getAppBar,
                drawer: const SideMenu(
                  menuName: StringConst.homeText,
                ),
                drawerScrimColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                body: BlocConsumer<CandidateBloc, CandidateState>(
                    builder: (_, state) {
                  return WillPopScope(
                    onWillPop: () async {
                      final shouldExit = await confirmAppExit();
                      if (shouldExit) SystemNavigator.pop();
                      return false;
                    },
                    child: _getHomeContainer,
                  );
                }, listener: (_, state) {
                  if (state is CandidateConfigsSuccess) {
                    isMaintenanceEnabled = state.data.data!["data"]
                        ["APP_MAINTENANCE"]["is_maintenance_enabled"];
                    appMaintenanceMessage =
                        state.data.data!["data"]["APP_MAINTENANCE"]["message"];
                    appMaintenancebkColor = state.data.data!["data"]
                        ["APP_MAINTENANCE"]["bg_color_code"];
                    final String maintenanceStartUtcDatetime =
                        state.data.data!["data"]["APP_MAINTENANCE"]
                            ["maintenance_start_utc_datetime"];
                    final String maintenanceEndUtcDatetime =
                        state.data.data!["data"]["APP_MAINTENANCE"]
                            ["maintenance_end_utc_datetime"];
                    final DateTime maintenanceStart =
                        DateTime.parse(maintenanceStartUtcDatetime).toLocal();
                    final DateTime maintenanceEnd =
                        DateTime.parse(maintenanceEndUtcDatetime).toLocal();
                    isInMaintenanceTime = now.isAfter(maintenanceStart) &&
                        now.isBefore(maintenanceEnd);
                    isArticleCampaignEnabled = state.data.data!["data"]
                        ["ARTICLE_CAMPAIGN"]["is_article_campaign_enabled"];
                    campaignMessage =
                        state.data.data!["data"]["ARTICLE_CAMPAIGN"]["message"];
                    campaignbkColor = state.data.data!["data"]
                        ["ARTICLE_CAMPAIGN"]["bg_color_code"];
                    final String campaignStartUtcDatetime =
                        state.data.data!["data"]["ARTICLE_CAMPAIGN"]
                            ["campaign_start_utc_datetime"];
                    final String campaignEndUtcDatetime =
                        state.data.data!["data"]["ARTICLE_CAMPAIGN"]
                            ["campaign_end_utc_datetime"];
                    final DateTime campaignStart =
                        DateTime.parse(campaignStartUtcDatetime).toLocal();
                    final DateTime campaignEnd =
                        DateTime.parse(campaignEndUtcDatetime).toLocal();
                    final isInCampaignTime =
                        now.isAfter(campaignStart) && now.isBefore(campaignEnd);
                    _campaignCheck(
                        isInCampaignTime ? isArticleCampaignEnabled : false);
                  }
                  if (state is CandidateUpdateAvailabilityStatusSuccess) {
                    if (state.data.data != null) {
                      showSuccessSnackBar(state.data.data!['message']);
                    }
                  }

                  if (state is CandidateUpdateAvailabilityStatusFail) {
                    if (state.message != '') {
                      showErrorSnackBar(state.message);
                    }
                  }

                  if (state is CandidateDeleteBigDataSuccess) {
                    if (state.data.data != null) {
                      _changeStatus();
                    }
                  }

                  if (state is CandidateDeleteBigDataFail) {
                    if (state.message != '') {
                      showErrorSnackBar(state.message);
                    }
                  }

                  if (state is CandidateCreateBigDataSuccess) {
                    if (state.data.data != null) {
                      Navigator.of(context).pop();
                      _changeStatus();
                    }
                  }

                  if (state is CandidateCreateBigDataFail) {
                    if (state.message != '') {
                      showErrorSnackBar(state.message);
                    }
                  }
                }))),
      );

  AppBar get _getAppBar => AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => _scaffoldKey.currentState!.openDrawer(),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Image.asset("assets/icons/menu.png")),
        ),
        leadingWidth: 52,
        title: _getLogo,
        elevation: 0.0,
        titleSpacing: 0.0,
        centerTitle: true,
        actions: candidateData != null
            ? [
                candidateData![DBUtils.candidateTableName] != null
                    ? _getActiveStatus
                    : Container(),
                _getNotification
              ]
            : [],
      );

  //App bar logo
  Widget get _getLogo => SizedBox(
        width: 56,
        height: 31,
        child: Image.asset('assets/images/logo.png'),
      );

  Widget get _getActiveStatus {
    return candidateData![DBUtils.candidateTableName] != null
        ? SizedBox(
            width: 70,
            child: AvailabilityStatusDropdown(
              initialValue: avaliblityStatus,
              onValueChanged: (value) {
                if (value !=
                    candidateData![DBUtils.candidateTableName]
                        ['availability_status']) {
                  // _updateAvaliability(value);
                  _changeCandiddateBigData(value);
                  setState(() {
                    status = value;
                  });
                }
              },
              title: 'Working Status',
            ),
          )
        : Container();
  }

  void showDialogFromFirebase() {
    if (Get.parameters.isNotEmpty) {
      String dialog = Get.parameters['dialog'] ?? '';
      if (dialog == "true") {
        String employerId = "${Get.parameters['employer_id']}";
        String notificationId = "${Get.parameters['notificationId']}";
        String currency = Get.parameters['currency'] ?? '';
        String expiry = Get.parameters['expiry'] ?? '';
        String salary = Get.parameters['salary'] ?? '';
        Future.delayed(
            const Duration(seconds: 2),
            () => Future(() => StringUtils.notificationScreenRoute(
                "notification2", context,
                expiry: expiry,
                currency: currency,
                salary: salary,
                notificationId: int.tryParse(notificationId) ?? 0,
                employerId: int.tryParse(employerId) ?? 0)));
      }
    }
  }

  Widget get _getNotification => SizedBox(
        width: 60,
        child: NotificationDropdown(
          title: 'Notification',
          onValueChanged: (value) {},
        ),
      );

  Widget get _getHomeContainer => Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                if (isInMaintenanceTime && isMaintenanceEnabled)
                  MarqueeTextHome(
                    message: appMaintenanceMessage,
                    colorCode: appMaintenancebkColor,
                    fontColor: Colors.white,
                    isShowIcon: true,
                  ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(
                            top: Sizes.padding10,
                            left: Sizes.padding20,
                            right: Sizes.padding20),
                        child: Column(children: [
                          _getHomeSearchFieldContainer,
                          _listenEmployerSearch,
                          const SportLightList(),
                          const SizedBox(
                            height: 10,
                          ),
                        ])),
                    _listenerArticleListHome,
                    Padding(
                        padding: const EdgeInsets.only(
                            left: Sizes.padding20,
                            right: Sizes.padding20,
                            bottom: 25),
                        child: Column(children: [
                          const AdsSlider(displayType: 'SLIDE'),
                          _listenerEventListHome(),
                          const CompanySocialLinks(),
                          _getPrivacyPolicy,
                          _getCopyright,
                          _versionNumberDisplay,
                        ])),
                  ],
                ),
              ],
            ),
          ),
        ],
      );

  Widget get _getHomeSearchFieldContainer => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus == null
            ? null
            : FocusManager.instance.primaryFocus!.unfocus(),
        child: PopupMenuButton<String>(
          constraints: BoxConstraints.tightFor(
              width: MediaQuery.of(context).size.width - 40),
          offset: const Offset(0, 58),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem<String>(
                  value: 'search',
                  enabled: false,
                  padding: EdgeInsets.all(10),
                  child: SimpleSearchModal())
            ];
          },
          child: _getHomeSearchField,
        ),
      );

  Widget get _getHomeSearchField => Container(
      height: 44,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.cardColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.0),
        border: const GradientBoxBorder(
          gradient: LinearGradient(colors: [
            Color(0xFFFFB6A0),
            Color(0xFFA5E3FD),
            Color(0xFF778AFF),
            Color(0xFFFFCBF2),
          ]),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${'Country of Work'.tr}   |   ${'Expected Salary'.tr}',
            style: const TextStyle(color: AppColors.white),
          ),
          const SizedBox(
            width: 10,
          ),
          const Icon(
            Icons.search,
            color: AppColors.white,
          )
        ],
      ));

  Widget get _listenerArticleListHome {
    if (isArticleCampaignEnabled) {
      return ArticleListHome(
        isArticleCampaignEnabled: isArticleCampaignEnabled,
        campaignMessage: campaignMessage,
        campaignbkColor: campaignbkColor,
      );
    }
    return const ArticleListHome();
  }

  Widget _listenerEventListHome() {
    return const EventListHome(
      itemCount: 3,
    );
  }

  //Privacy Policy
  Widget get _getPrivacyPolicy => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Get.toNamed(termsAndPolicyRoute, arguments: 1),
              child: const Text(
                StringConst.termsOfServiceText,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.primaryGrey,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 15,
              width: 1,
              color: AppColors.primaryGrey,
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () => Get.toNamed(termsAndPolicyRoute, arguments: 2),
              child: const Text(
                StringConst.privacyText,
                style: TextStyle(fontSize: 12, color: AppColors.primaryGrey),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 15,
              width: 1,
              color: AppColors.primaryGrey,
            ),
            const SizedBox(
              width: 10,
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () => Get.toNamed(termsAndPolicyRoute, arguments: 3),
              child: const Text(
                StringConst.eulaText,
                style: TextStyle(fontSize: 12, color: AppColors.primaryGrey),
              ),
            ),
          ],
        ),
      );

  Widget get _getCopyright => Padding(
        padding: const EdgeInsets.only(bottom: 2.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          child: const Text(
            StringConst.phluidCopyRight,
            style: TextStyle(
              color: AppColors.primaryGrey,
              fontSize: 12,
            ),
          ),
        ),
      );

  Widget get _versionNumberDisplay {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      FutureBuilder(
          future: VersionHelper.getCurrentAppVersion(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                snapshot.data!.versionString,
                style:
                    TextStyle(color: Colors.grey.withAlpha(100), fontSize: 12),
              );
            }
            return Container();
          })
    ]);
  }

  Widget get _listenEmployerSearch =>
      BlocConsumer<EmployerBloc, EmployerState>(builder: (_, state) {
        return const SizedBox.shrink();
      }, listener: (_, state) {
        if (state is EmployerSearchCreateSuccess) {
          Loading.cancelLoading();
          if (state.employerData.data != null) {
            // showSuccessSnackBar(context, state.data.data!['message']);
            _showRevealSearchesModal(state.employerData.data);
            DBUtils.saveNewData(state.employerData.data, 'search_result');
          }
        }

        if (state is EmployerSearchCreateFail) {
          Loading.cancelLoading();
          if (state.message != '') {
            showErrorSnackBar(state.message);
          }
        }
      });

  //Reveal Searches
  void _showRevealSearchesModal(Map<String, dynamic>? data) {
    Future.delayed(const Duration(milliseconds: 100), () {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          _animationController.forward(from: 0.0);

          return SlideTransition(
            position: _animation,
            child:
                RevealSearchPopUp(employerData: data!, isAdvancedSearch: false),
          );
        },
      );
    });
  }

  void showNotification(String title, String body, String id) {
    Noti.showNotification(
        id: int.parse(id), title: title, body: body, payload: id.toString());
  }

  void _changeCandiddateBigData(String status) {
    switch (status) {
      case 'Not Available':
        _deleteBigData();
        break;
      default:
        _showChangeBigData(status);
        break;
    }
  }

  void _deleteBigData() {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateDeleteBigDataRequestParams params =
        CandidateDeleteBigDataRequestParams(
            token: candidateData!['token'], userId: candidateData!['user_id']);
    candidateBloc.add(CandidateDeleteBigDataRequested(params: params));
  }

  void _showChangeBigData(String status) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      context: context,
      enableDrag: false,
      isDismissible: false,
      isScrollControlled: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.9,
          builder: (context, scrollController) {
            return SaveBigDataModal(
              controller: scrollController,
              status: status,
            );
          },
        );
      },
    );
  }

  void _changeStatus() {
    setState(() {
      avaliblityStatus = status;
    });
    candidateData![DBUtils.candidateTableName]['availability_status'] = status;
    DBUtils.saveNewData({'data': candidateData}, DBUtils.candidateTableName);
  }
}
