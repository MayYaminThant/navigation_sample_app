part of '../../views.dart';

class StarListSection extends StatefulWidget {
  const StarListSection({Key? key}) : super(key: key);

  @override
  State<StarListSection> createState() => _StarListSectionState();
}

class _StarListSectionState extends State<StarListSection> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentPage = 0;
  final PageController _pageController = PageController();
  List<StarList> starList = [];
  String starId = "";

  Map? employerData;
  bool isShowConnect = false;
  bool isLoading = false;

  @override
  void initState() {
    _getCandidateData();
    super.initState();
  }

  _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      employerData = box.get(DBUtils.employerTableName);
    });
    if (employerData![DBUtils.employerTableName] != null) _requestStarList();
  }

  _requestStarList() {
    final candidateBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerStarListRequestParams params =
        EmployerStarListRequestParams(token: employerData!['token']);
    candidateBloc.add(EmployerStarListRequested(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployerBloc, EmployerState>(builder: (_, state) {
      return _buildStarListScaffold();
    }, listener: (_, state) {
      if (state is EmployerStarListLoading) {
        _setLoading(true);
      }
      if (state is EmployerStarListSuccess) {
        _setLoading(false);
        if (state.data.data != null) {
          print((state.data.data!['data'] as List<dynamic>)
              .map((e) => StarListModel.fromJson(e as Map<String, dynamic>)));
          List<StarList> dataList = List<StarList>.from((state
                  .data.data!['data'] as List<dynamic>)
              .map((e) => StarListModel.fromJson(e as Map<String, dynamic>)));
          setState(() {
            starList = dataList;
          });

          //
        }
      }
      if (state is EmployerStarListFail) {
        _setLoading(false);
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is EmployerStarListRemoveSuccess) {
        if (state.data.data != null) {
          showSuccessSnackBar(state.data.data!['message']);
          _requestStarList();
        }
      }
      if (state is EmployerStarListRemoveFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  Widget _buildStarListScaffold() {
    return BackgroundScaffold(
      onWillPop: () => Get.offAllNamed(rootRoute),
      scaffold: isLoading
          ? LoadingScaffold.getLoading()
          : Scaffold(
              key: _scaffoldKey,
              appBar: _buildAppBar(),
              drawer: const SideMenu(menuName: StringConst.starListText),
              drawerScrimColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              body: employerData != null &&
                      employerData![DBUtils.employerTableName] != null
                  ? _getStarListContainer
                  : const Center(child: EmptyProfileContainer()),
              bottomNavigationBar: starList.isEmpty
                  ? null
                  : isShowConnect
                      ? Container(
                          color: AppColors.primaryColor,
                          height: 70,
                          child: GestureDetector(
                            onTap: () => setState(() {
                              starList.removeAt(_currentPage);
                              if (starList.isEmpty) isShowConnect = false;
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
                                  StringConst.removeFromStarText,
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
                          pageCount: starList.length + 1,
                        ),
            ),
    );
  }

  Widget get _getStarListContainer => starList.isEmpty
      ? const EmptyMessage(
          title: 'Opps! No Star List yet...',
          image: 'assets/images/empty-result.png',
          description: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text:
                        'Discover your dream offers and keep them at your fingertips! With a limit of 7 offers per account, you can easily search and compare your favorites again and again.',
                    style: TextStyle(
                        fontSize: 14, color: AppColors.primaryGrey, height: 2)),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        )
      : PageView(
          controller: _pageController,
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          pageSnapping: true,
          physics: isShowConnect ? const NeverScrollableScrollPhysics() : null,
          children: List.generate(
            starList.length + 1,
            (index) => index == starList.length
                ? const ProfilDeskSection()
                : _buildStarListContainer(starList[index]),
          ),
        );

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
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: InkWell(
                onTap: () => _scaffoldKey.currentState!.openDrawer(),
                child: Image.asset("assets/icons/menu.png"),
              ),
            ),
            leadingWidth: 52,
            title: const Text(
              'Star List',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            elevation: 0.0,
            titleSpacing: 0.0,
            centerTitle: true,
          );
  }

  Widget _buildStarListContainer(StarList data) {
    return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: CandidateProfileItem(
          candidate: data.candidate!,
          onChatPressed: () => _showLetChat(),
          onStarPressed: () => _requestRemoveStarList(data.id!),
          isStarList: true,
          isBottomBar: true,
            isShowConnect: isShowConnect
        ),
      );
  }

  _requestRemoveStarList(int starId) {
    final employerBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerStarListRemoveRequestParams params =
        EmployerStarListRemoveRequestParams(
            token: employerData!['token'], starId: starId);
    employerBloc.add(EmployerStarListRemoveRequested(params: params));
  }

  _showLetChat() => setState(() {
        isShowConnect = !isShowConnect;
      });

  _checkValidation() {
    if (employerData != null) {
      employerData![DBUtils.employerTableName] != null
          ? _createSendConnection()
          : showEmptyProfileModal(context, route: searchResultPageRoute);
    }
  }

  //Send Connection
  _createSendConnection() {
    final connnectionBloc =
        BlocProvider.of<kConnectionBloc.ConnectionBloc>(context);
    ConnectionSendRequestParams params = ConnectionSendRequestParams(
        senderUserId: employerData!['user_id'],
        token: employerData!['token'],
        appSiloName: kAppSilo,
        receiverUserId: starList[_currentPage].candidate!.id);
    connnectionBloc
        .add(kConnectionBloc.ConnectionSendRequested(params: params));
  }

  void _setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }
}
