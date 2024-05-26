part of '../../views.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({super.key});

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map? employerData;
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  String countryName = '';
  int agentFee = 0;
  String currency = '';
  final TextEditingController expectedSalaryController =
      TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  String basePhotoUrl = '';
  String status = '';
  String avaliblityStatus = '';

  @override
  void initState() {
    _checkForResume();
    _initializeAnimation();
    _getPhotoUrl();
    _getEmployerData();

    super.initState();
  }

  _checkForResume() {
    Future.delayed(Duration.zero, () {
      final loginResume = LoginResume();
      loginResume.resumeState();
    });
  }

  _initializeAnimation() {
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

  void _showJoinModal() {
    Future.delayed(const Duration(milliseconds: 100), () {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldExit = await confirmAppExit();
        if (shouldExit) SystemNavigator.pop();
        return false;
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: BlocConsumer<EmployerBloc, EmployerState>(builder: (_, state) {
          return _homeScaffold;
        }, listener: (_, state) {
          if (state is EmployerUpdateAvailabilityStatusFail) {
            if (state.message != '') {
              showInfoModal(message: state.message, type: 'error');
            }
          }

          if (state is EmployerDeleteOfferSuccess) {
            if (state.data.data != null) {
              _changeStatus();
            }
          }

          if (state is EmployerDeleteOfferFail) {
            if (state.message != '') {
              showErrorSnackBar(state.message);
            }
          }

          if (state is EmployerCreateOfferSuccess) {
            if (state.data.data != null) {
              Navigator.of(context).pop();
              print("sucessssss");
              showSuccessSnackBar(state.data.data!['message']);
              _changeStatus();
            }
          }

          if (state is EmployerCreateOfferFail) {
            if (state.message != '') {
              showErrorSnackBar(state.message);
            }
          }
        }),
      ),
    );
  }

  Widget get _homeScaffold => SingleChildScrollView(
        child: BackgroundScaffold(
            scaffold: Scaffold(
          key: _scaffoldKey,
          appBar: _getAppBar,
          drawer: const SideMenu(
            menuName: StringConst.homeText,
          ),
          drawerScrimColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          body: _getHomeContainer,
        )),
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
        actions: employerData != null
            ? [
                employerData![DBUtils.employerTableName] != null
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
    return SizedBox(
      width: 70,
      child: AvailabilityStatusDropdown(
        initialValue: avaliblityStatus,
        onValueChanged: (value) {
          if (value !=
              employerData![DBUtils.employerTableName]['availability_status']) {
            _changeCandidateBigData(value);
            setState(() {
              status = value;
            });
          }
        },
        title: 'Working Status',
      ),
    );
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
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.padding20, vertical: Sizes.padding20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _getHomeSearchFieldContainer,
                  _listenCandidateSearch,
                  const SportLightList(),
                  const SizedBox(
                    height: 10,
                  ),
                  _listenerArticleListHome(),
                  const AdsSlider(displayType: 'SLIDE'),
                  // const AdsSlider(displayType: 'fade'),
                  _listenerEventListHome(),
                  const CompanySocialLinks(),
                  _getPrivacyPolicy,
                  _getCopyright,
                  _versionNumberDisplay,
                ],
              ),
            ),
          ),
        ],
      );

  get _getHomeSearchFieldContainer => PopupMenuButton<String>(
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
        child: Container(
          child: _getHomeSearchField,
        ),
      );

  get _getHomeSearchField => Container(
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                '${StringConst.dhNationalityText.tr}   |   ${StringConst.expectedSalaryText.tr}',
                style: const TextStyle(color: AppColors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(
              Icons.search,
              color: AppColors.white,
            ),
          )
        ],
      ));

  Widget _listenerArticleListHome() {
    return const ArticleListHome(
      itemCount: 3,
    );
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

  //copyright
  Widget get _getCopyright => Padding(
        padding: const EdgeInsets.only(bottom: 2.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: const Text(
            StringConst.phluidCopyRight,
            style: TextStyle(
              color: AppColors.primaryGrey,
              fontSize: 12,
            ),
          ),
        ),
      );

  //Version Text
  Widget get _versionNumberDisplay {
    return FutureBuilder(
        future: VersionHelper.getCurrentAppVersion(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(
              snapshot.data!.versionString,
              style: TextStyle(color: Colors.grey.withAlpha(100), fontSize: 12),
            );
          }
          return Container();
        });
  }

  _getEmployerData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    Map? data = box.get(DBUtils.employerTableName);
    if (data == null) {
      _showJoinModal();
    } else {
      setState(() {
        employerData = data;
      });
    }
  }

  void _getPhotoUrl() async {
    String data = await DBUtils.getEmployerConfigs(DBUtils.stroagePrefix);
    setState(() {
      basePhotoUrl = data;
    });
  }

  Widget get _listenCandidateSearch =>
      BlocConsumer<CandidateBloc, CandidateState>(builder: (_, state) {
        return const SizedBox.shrink();
      }, listener: (_, state) {
        if (state is CandidateSearchCreateSuccess) {
          Loading.cancelLoading();
          if (state.candidateData.data != null) {
            _showRevealSearchesModal(state.candidateData.data);
            DBUtils.saveNewData(state.candidateData.data, 'search_result');
          }
        }

        if (state is CandidateSearchCreateFail) {
          Loading.cancelLoading();
          if (state.message != '') {
            showInfoModal(message: state.message, type: 'error');
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
            child: RevealSearchPopUp(
                candidateData: data!, isAdvancedSearch: false),
          );
        },
      );
    });
  }

  void _changeCandidateBigData(String status) {
    switch (status) {
      case 'Not Hiring':
        _deleteBigData();
        break;
      default:
        _showChangeBigData(status);
        break;
    }
  }

  void _deleteBigData() {
    final candidateBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerDeleteOfferRequestParams params = EmployerDeleteOfferRequestParams(
        token: employerData!['token'], userId: employerData!['user_id']);
    candidateBloc.add(EmployerDeleteOfferRequested(params: params));
  }

  _showChangeBigData(String status) {
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
            return SaveOfferModal(
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
    employerData![DBUtils.employerTableName]['availability_status'] = status;
    DBUtils.saveNewData({'data': employerData}, DBUtils.employerTableName);
  }
}
