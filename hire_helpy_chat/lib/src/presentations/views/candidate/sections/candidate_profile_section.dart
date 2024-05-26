part of '../../views.dart';

class CandidateProfileSection extends StatefulWidget {
  const CandidateProfileSection({super.key});

  @override
  State<CandidateProfileSection> createState() =>
      _CandidateProfileSectionState();
}

class _CandidateProfileSectionState extends State<CandidateProfileSection> {
  Candidate? candidate;
  Map? employerData;
  bool isShowConnect = false;
  String route = '';
  int _currentPage = 0;
  late PageController _pageController = PageController(keepPage: false);
  List<Candidate> candidateList = [];

  @override
  void initState() {
    _initializeDatas();
    _getCandidateData();
    super.initState();
  }

  _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    employerData = box.get(DBUtils.employerTableName);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CandidateBloc, CandidateState>(
      builder: (_, state) {
        return BackgroundScaffold(
          onWillPop: () => Get.back(),
          scaffold: candidateList.isEmpty
              ? LoadingScaffold.getLoading()
              : _getCandidateProfileScaffold,
        );
      },
      listener: (_, state) {
        if (state is CandidatePublicProfileSuccess) {
          if (state.candidateData.data != null) {
            candidate =
                CandidateModel.fromJson(state.candidateData.data!['data']);
            setState(() {
              candidateList = [candidate!];
            });
          }
        }

        if (state is CandidatePublicProfileFail) {
          if (state.message != '') {
            showErrorSnackBar(state.message);
          }
        }
      },
    );
  }

  Scaffold get _getCandidateProfileScaffold {
    return Scaffold(
      appBar: _getAppBar,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                pageSnapping: true,
                physics:
                    isShowConnect ? const NeverScrollableScrollPhysics() : null,
                children: List.generate(
                  candidateList.length + 1,
                  (index) => index == candidateList.length
                      ? const ProfilDeskSection()
                      : _buildCandidateProfileContainer(candidateList[index]),
                ),
              )),
        ],
      ),
      bottomNavigationBar: isShowConnect && candidateList.length > 1
          ? Container(
              color: AppColors.primaryColor,
              height: 70,
              child: GestureDetector(
                onTap: () => _removeFromList(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Iconsax.trash,
                      size: 24,
                      color: AppColors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      StringConst.removeFromStackText,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white),
                    ),
                  ],
                ),
              ),
            )
          : PageViewIndicator(
              currentPage: _currentPage,
              pageCount: candidateList.length + 1,
            ),
    );
  }

  AppBar get _getAppBar => isShowConnect
      ? AppBar(
          backgroundColor: AppColors.primaryColor,
          automaticallyImplyLeading: false,
          title: GestureDetector(
            onTap: () => _checkValidation(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Iconsax.message,
                  size: 24,
                  color: AppColors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  StringConst.letChatText,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white),
                ),
              ],
            ),
          ),
          elevation: 0.0,
          titleSpacing: 0.0,
          centerTitle: true,
        )
      : AppBar(
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () => route != '' ? Get.offAllNamed(route) : Get.back(),
            child: const Icon(
              Iconsax.arrow_left,
              color: AppColors.white,
            ),
          ),
          leadingWidth: 52,
          title: Text(
            StringConst.candidateProfile.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.w100),
          ),
          elevation: 0.0,
          titleSpacing: 0.0,
          centerTitle: true,
          actions: const [],
        );

  _buildCandidateProfileContainer(Candidate data) {
    return Column(
      children: [
        Expanded(
          child: CandidateProfileItem(
              candidate: data,
              onChatPressed: () => _showLetChat(),
              isStarList: false,
              isBottomBar: true,
              isShowConnect: isShowConnect),
        ),
        _getListenConnection,
      ],
    );
  }

  _initializeDatas() {
    if (Get.arguments.isNotEmpty) {
      int candidateId = Get.arguments['id'] != null ? int.parse(Get.arguments['id'].toString()) : 0;
      route = Get.arguments['route'] ?? '';
      //print('data ${json.decode(Get.parameters['list'].toString())}');
      candidateList = Get.arguments['list'] != null
          ? Get.arguments['list'] as List<Candidate>
          : [];
      _currentPage = Get.arguments['index'] != null
          ? int.parse(Get.arguments['index'].toString())
          : 0;
      if (_currentPage != 0) {
        _pageController = PageController(initialPage: _currentPage);
      }

      if (candidateList.isEmpty) {
        _requestCandidatePublicProfile(candidateId);
      }
    }
  }

  void _requestCandidatePublicProfile(int profileId) {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidatePublicProfileRequestParams params =
        CandidatePublicProfileRequestParams(candidateId: profileId);
    candidateBloc.add(CandidatePublicProfileRequested(params: params));
  }

  _showLetChat() => setState(() {
        isShowConnect = !isShowConnect;
      });

  _checkValidation() {
    if (employerData != null) {
      employerData![DBUtils.employerTableName] != null
          ? _createSendConnection()
          : showEmptyProfileModal(context, route: searchResultPageRoute);
    } else {
      _showJoinModal();
      _showLetChat();
    }
  }

  void _showJoinModal() {
    Future.delayed(const Duration(milliseconds: 100), () {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return const RegisterEnjoyPopUp();
        },
      );
    });
  }

  //Send Connection
  _createSendConnection() {
    final connnectionBloc =
        BlocProvider.of<kConnectionBloc.ConnectionBloc>(context);
    ConnectionSendRequestParams params = ConnectionSendRequestParams(
        senderUserId: employerData!['user_id'],
        token: employerData!['token'],
        appSiloName: kAppSilo,
        receiverUserId: candidateList[_currentPage].id);
    connnectionBloc
        .add(kConnectionBloc.ConnectionSendRequested(params: params));
  }

  Widget get _getListenConnection {
    return BlocConsumer<kConnectionBloc.ConnectionBloc,
        kConnectionBloc.ConnectionState>(builder: (_, state) {
      return Container();
    }, listener: (_, state) {
      if (state is kConnectionBloc.ConnectionSendRequestSuccess) {
        if (state.connectionData.data != null) {
          setState(() {
            isShowConnect = false;
          });
        }
      }

      if (state is kConnectionBloc.ConnectionSendRequestFail) {
        setState(() {
          isShowConnect = false;
        });
      }
    });
  }

  _removeFromList() {
    setState(() {
      candidateList.removeAt(_currentPage);
      if (candidateList.length == 1) isShowConnect = false;
    });
  }
}
