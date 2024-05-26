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

  Map? candidateData;
  bool isShowConnect = false;
  bool isLoading = true;

  @override
  void initState() {
    _getCandidateData();
    super.initState();
  }

  _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      candidateData = box.get(DBUtils.candidateTableName);
    });
    _requestStarList();
  }

  _requestStarList() {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateStarListRequestParams params =
        CandidateStarListRequestParams(token: candidateData!['token']);
    candidateBloc.add(CandidateStarListRequested(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CandidateBloc, CandidateState>(builder: (_, state) {
      return _buildStarListScaffold();
    }, listener: (_, state) {
      if (state is CandidateStarListLoading) {
        _setLoading(true);
      }
      if (state is CandidateStarListSuccess) {
        _setLoading(false);
        if (state.data.data != null) {
          List<StarList> dataList = List<StarList>.from((state
                  .data.data!['data'] as List<dynamic>)
              .map((e) => StarListModel.fromJson(e as Map<String, dynamic>)));
          setState(() {
            starList = dataList;
          });
        }
      }
      if (state is CandidateStarListFail) {
        _setLoading(false);
        if (state.message != '') {
       //   showErrorSnackBar(state.message);
        }
      }

      if (state is CandidateStarListRemoveSuccess) {
        if (state.data.data != null) {
          showSuccessSnackBar(state.data.data!['message']);
          _requestStarList();
        }
      }
      if (state is CandidateStarListRemoveFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is CandidateDeleteBigDataFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is CandidateCreateBigDataFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  Widget _buildStarListScaffold() {
    return BackgroundScaffold(
      scaffold: isLoading
          ? LoadingScaffold.getLoading()
          : Scaffold(
              key: _scaffoldKey,
              appBar: _buildAppBar(),
              drawer: const SideMenu(menuName: StringConst.starListText),
              drawerScrimColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              body: candidateData != null &&
                      candidateData![DBUtils.candidateTableName] != null
                  ? _getStarListContainer
                  : SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: const Center(child: EmptyProfileContainer())),
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
      ? EmptyMessage(
          title: 'Opps! No Star List yet...'.tr,
          image: 'assets/images/empty-result.png',
          description: const Text.rich(
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
                children: [
                  const Icon(
                    Iconsax.message,
                    size: 24,
                    color: AppColors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    StringConst.letChatText.tr,
                    style: const TextStyle(
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
            title: Text(
              StringConst.starListText.tr,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            elevation: 0.0,
            titleSpacing: 0.0,
            centerTitle: true,
          );
  }

  Widget _buildStarListContainer(StarList data) {
    return GestureDetector(
      onTap: () => _showLetChat(),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: EmployeerProfileItem(
          employer: data.employer!,
          onChatPressed: () => _showLetChat(),
          onStarPressed: () => _requestRemoveStarList(data.id!),
          isStarList: true,
          isBottomBar: true,
        ),
      ),
    );
  }

  _requestRemoveStarList(int starId) {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateStarListRemoveRequestParams params =
        CandidateStarListRemoveRequestParams(
            token: candidateData!['token'], starId: starId);
    candidateBloc.add(CandidateStarListRemoveRequested(params: params));
  }

  _showLetChat() => setState(() {
        isShowConnect = !isShowConnect;
      });

  _checkValidation() {
    if (candidateData != null) {
      candidateData![DBUtils.candidateTableName] != null
          ? _createSendConnection()
          : showEmptyProfileModal(context, route: searchResultPageRoute);
    }
  }

  //Send Connection
  _createSendConnection() {
    final connnectionBloc =
        BlocProvider.of<k_connection_bloc.ConnectionBloc>(context);
    ConnectionSendRequestParams params = ConnectionSendRequestParams(
        senderUserId: candidateData!['user_id'],
        token: candidateData!['token'],
        appSiloName: kAppSilo,
        receiverUserId: starList[_currentPage].employer!.id);
    connnectionBloc
        .add(k_connection_bloc.ConnectionSendRequested(params: params));
  }

  void _setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }
}
