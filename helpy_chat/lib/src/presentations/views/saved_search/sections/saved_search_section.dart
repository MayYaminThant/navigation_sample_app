part of '../../views.dart';

class SavedSearchSection extends StatefulWidget {
  const SavedSearchSection({super.key});

  @override
  State<SavedSearchSection> createState() => _SavedSearchSectionState();
}

class _SavedSearchSectionState extends State<SavedSearchSection> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map? candidateData;

  List<SavedSearch> savedSearchList = [];
  bool isLoading = true;

  @override
  void initState() {
    _getCandidateData();
    super.initState();
  }

  _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    candidateData = box.get(DBUtils.candidateTableName);
    _requestSavedSearch();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(scaffold: _getSavedSearchScaffold);
  }

  //Saved Search Scaffold
  Scaffold get _getSavedSearchScaffold => Scaffold(
        key: _scaffoldKey,
        appBar: _getAppBar,
        drawer: const SideMenu(
          menuName: StringConst.savedSearchText,
        ),
        drawerScrimColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        body: _getSavedSearchContainer,
      );

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
        StringConst.savedSearchText.tr,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      elevation: 0.0,
      titleSpacing: 0.0,
      centerTitle: true,
    );
  }

  Widget get _getSavedSearchContainer {
    return BlocConsumer<CandidateBloc, CandidateState>(builder: (_, state) {
      return isLoading
          ? LoadingScaffold.getLoading()
          : savedSearchList.isEmpty
              ? const EmptySavedSearchItem()
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.padding20,
                      vertical: Sizes.padding20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          StringConst.savedSearchTitle.tr,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: savedSearchList.length,
                          itemBuilder: (context, index) {
                            return SavedSearchCard(
                                savedSearch: savedSearchList[index]);
                          },
                        ),
                        if (savedSearchList.isNotEmpty)
                          AutoSendNotification(
                            saveSearchList: savedSearchList,
                          )
                      ],
                    ),
                  ),
                );
    }, listener: (_, state) {
      if (state is CandidateSaveSearchListLoading) {
        _setLoading(true);
      }

      if (state is CandidateSaveSearchListSuccess) {
        _setLoading(false);
        if (state.data.data != null) {
          List<SavedSearch> data = List<SavedSearch>.from(
              (state.data.data!['data']['data'] as List<dynamic>).map(
                  (e) => SavedSearchModel.fromJson(e as Map<String, dynamic>)));
          setState(() {
            savedSearchList = data;
          });
        }
      }

      if (state is CandidateSaveSearchListFail) {
        _setLoading(false);
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is CandidateDeleteSaveSearchSuccess) {
        if (state.data.data != null) {
          showSuccessSnackBar(state.data.data!['message']);
          _requestSavedSearch();
        }
      }

      if (state is CandidateDeleteSaveSearchFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is CandidateUpdateSaveSearchSuccess) {
        if (state.data.data != null) {
          showSuccessSnackBar(state.data.data!['message']);
          _requestSavedSearch();
        }
      }

      if (state is CandidateUpdateSaveSearchFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is CandidateNotifySaveSearchSuccess) {
        if (state.data.data != null) {
          showSuccessSnackBar(state.data.data!['message']);
          _requestSavedSearch();
        }
      }

      if (state is CandidateNotifySaveSearchFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  _requestSavedSearch() {
    final candidateBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateSaveSearchRequestParams params = CandidateSaveSearchRequestParams(
        token: candidateData!['token'], userId: candidateData!['user_id']);
    candidateBloc.add(CandidateSaveSearchListRequested(params: params));
  }

  void _setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }
}
