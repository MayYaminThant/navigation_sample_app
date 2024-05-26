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
  List<Employer> employerList = [];
  bool isShowConnect = false;
  Map? candidateData;
  String route = '';

  @override
  void initState() {
    _getCandidateData();
    super.initState();
  }

  _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    candidateData = box.get(DBUtils.candidateTableName);
    Map? employerData = box.get('search_result');

    if (Get.parameters.isNotEmpty) {
      route = Get.parameters['route'] ?? '';
    }

    if (employerData != null) {
      setState(() {
        employerList = List<Employer>.from(
            (employerData['profiles'] as List<dynamic>)
                .map((e) => EmployerModel.fromJson(e as Map<String, dynamic>)));
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
    return BlocConsumer<k_connection_bloc.ConnectionBloc,
        k_connection_bloc.ConnectionState>(builder: (_, state) {
      return BackgroundScaffold(scaffold: _getSearchResultScaffold);
    }, listener: (_, state) {
      if (state is k_connection_bloc.ConnectionSendRequestSuccess) {
        if (state.connectionData.data != null) {
          setState(() {
            isShowConnect = false;
          });
          showInfoModal(
              title: 'You have successfully sent a chat request.',
              message: 'You can check it on the chat page.',
              type: 'success');
        }
      }

      if (state is k_connection_bloc.ConnectionSendRequestFail) {
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
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: employerList.isNotEmpty
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
                      employerList.length + 1,
                      (index) => index == employerList.length
                          ? const ProfilDeskSection()
                          : _buildStarListContainer(employerList[index]),
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
      bottomNavigationBar: isShowConnect && employerList.length > 1
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
              pageCount: employerList.length + 1,
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
            leading: GestureDetector(
              onTap: () => Get.offAllNamed(route),
              child: const Icon(
                Iconsax.arrow_left,
                color: AppColors.white,
              ),
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

  Widget _buildStarListContainer(Employer employer) {
    return GestureDetector(
      onTap: () => _showLetChat(),
      child: EmployeerProfileItem(
        employer: employer,
        onChatPressed: () => _showLetChat(),
        isStarList: false,
        isBottomBar: true,
      ),
    );
  }

  _showLetChat() => setState(() {
        isShowConnect = !isShowConnect;
      });

  _checkValidation() {
    if (candidateData != null) {
      candidateData![DBUtils.candidateTableName] != null
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
        BlocProvider.of<k_connection_bloc.ConnectionBloc>(context);
    ConnectionSendRequestParams params = ConnectionSendRequestParams(
        senderUserId: candidateData!['user_id'],
        token: candidateData!['token'],
        appSiloName: kAppSilo,
        receiverUserId: employerList[_currentPage].id);
    connnectionBloc
        .add(k_connection_bloc.ConnectionSendRequested(params: params));
  }

  _removeFromList() {
    setState(() {
      employerList.removeAt(_currentPage);
      if (employerList.length == 1) isShowConnect = false;
    });
  }
}
