part of '../../views.dart';

class SearchResultSection extends StatefulWidget {
  const SearchResultSection({Key? key}) : super(key: key);

  @override
  State<SearchResultSection> createState() => _SearchResultSectionState();
}

class _SearchResultSectionState extends State<SearchResultSection> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentPage = 0;
  final PageController _pageController = PageController(keepPage: false);
  List<Candidate> candidateList = [];
  bool isShowConnect = false;
  Map? employerData;

  @override
  void initState() {
    _getCandidateData();
    super.initState();
  }

  _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    employerData = box.get(DBUtils.employerTableName);
    Map? searchResultList = box.get('search_result');

    if (searchResultList != null) {
      setState(() {
        candidateList = List<Candidate>.from((searchResultList['profiles']
                    as List<dynamic>)
                .map((e) => CandidateModel.fromJson(e as Map<String, dynamic>)))
            .where((i) => i.id! > 195)
            .toList();
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<kConnectionBloc.ConnectionBloc, kConnectionBloc.ConnectionState>(builder: (_, state) {
       return BackgroundScaffold(scaffold: _getSearchResultScaffold);
    }, listener: (_, state) {
      if (state is kConnectionBloc.ConnectionSendRequestSuccess) {
        if (state.connectionData.data != null) {
           showSuccessSnackBar(state.connectionData.data!['message']);
        }
      }
      
      if (state is kConnectionBloc.ConnectionSendRequestFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
    
  }

  Scaffold get _getSearchResultScaffold {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      drawer: const SideMenu(menuName: ''),
      drawerScrimColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: candidateList.isNotEmpty
                ? PageView(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    pageSnapping: true,
                    physics: isShowConnect
                        ? const NeverScrollableScrollPhysics()
                        : null,
                    children: List.generate(
                      candidateList.length + 1,
                      (index) => index == candidateList.length
                          ? const ProfilDeskSection()
                          : _buildStarListContainer(candidateList[index]),
                    ),
                  )
                : const EmptySearchResultItem(),
          ),
          if (isShowConnect)
            GestureDetector(
                onTap: () => _showLetChat(),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.black.withOpacity(0.3),
                  ),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ))
        ],
      ),
      bottomNavigationBar: isShowConnect && candidateList.length >1
          ? Container(
              color: AppColors.primaryColor,
              height: 70,
              child: GestureDetector(
                onTap: () => setState(() {
                  candidateList.removeAt(_currentPage);
                  if (candidateList.isEmpty) isShowConnect = false;
                }),
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
              pageCount: candidateList.length +1,
            ),
    );
  }

  AppBar _buildAppBar() {
    return isShowConnect
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
              onTap: () => _scaffoldKey.currentState!.openDrawer(),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Image.asset("assets/icons/menu.png")),
            ),
            leadingWidth: 52,
            title: Text(
              StringConst.searchResultsText.tr,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            elevation: 0.0,
            titleSpacing: 0.0,
            centerTitle: true,
          );
  }

  Widget _buildStarListContainer(Candidate candidate) {
    return CandidateProfileItem(
        candidate: candidate,
        onChatPressed: () => _showLetChat(),
        isStarList: false,
        isBottomBar: true,
        isShowConnect: isShowConnect
      );
  }

  _showLetChat() => setState(() {
        isShowConnect = !isShowConnect;
      });

  _checkValidation() {
    if (employerData != null) {
      employerData![DBUtils.employerTableName] != null
          ? _createSendConnection()
          : showEmptyProfileModal(context, route: searchResultPageRoute);
    }else {
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

  _createSendConnection() {
    final connectionBloc =
        BlocProvider.of<kConnectionBloc.ConnectionBloc>(context);
    ConnectionSendRequestParams params = ConnectionSendRequestParams(
        senderUserId: employerData!['user_id'],
        token: employerData!['token'],
        appSiloName: kAppSilo,
        receiverUserId: candidateList[_currentPage].id);
    connectionBloc.add(kConnectionBloc.ConnectionSendRequested(params: params));
  }
}
