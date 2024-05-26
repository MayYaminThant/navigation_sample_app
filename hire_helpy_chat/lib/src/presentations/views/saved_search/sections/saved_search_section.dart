part of '../../views.dart';

class SavedSearchSection extends StatefulWidget {
  const SavedSearchSection({super.key});

  @override
  State<SavedSearchSection> createState() => _SavedSearchSectionState();
}

class _SavedSearchSectionState extends State<SavedSearchSection> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map? employerData;

  List<SavedSearch> savedSearchList = [];
  bool isLoading = false;

  @override
  void initState() {
    _getEmployerData();
    super.initState();
  }

  _getEmployerData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    employerData = box.get(DBUtils.employerTableName);
    if (employerData != null &&
        employerData![DBUtils.employerTableName] != null) _requestSavedSearch();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployerBloc, EmployerState>(builder: (_, state) {
      return BackgroundScaffold(
          onWillPop: () => Get.offAllNamed(rootRoute),
          scaffold: isLoading
              ? LoadingScaffold.getLoading()
              : _getSavedSearchScaffold);
    }, listener: (_, state) {
      if (state is EmployerSaveSearchListLoading) {
        _setLoading(true);
      }

      if (state is EmployerSaveSearchListSuccess) {
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

      if (state is EmployerSaveSearchListFail) {
        _setLoading(false);
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is EmployerDeleteSaveSearchSuccess) {
        if (state.data.data != null) {
          showSuccessSnackBar(state.data.data!['message']);
          _requestSavedSearch();
        }
      }

      if (state is EmployerDeleteSaveSearchFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is EmployerUpdateSaveSearchSuccess) {
        if (state.data.data != null) {
          showSuccessSnackBar(state.data.data!['message']);
          _requestSavedSearch();
        }
      }

      if (state is EmployerUpdateSaveSearchFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }

      if (state is EmployerNotifySaveSearchSuccess) {
        if (state.data.data != null) {
          showSuccessSnackBar(state.data.data!['message']);
          _requestSavedSearch();
        }
      }

      if (state is EmployerNotifySaveSearchFail) {
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
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
      title: const Text(
        StringConst.savedSearchText,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      elevation: 0.0,
      titleSpacing: 0.0,
      centerTitle: true,
    );
  }

  Widget get _getSavedSearchContainer {
    return savedSearchList.isEmpty
        ? const EmptySavedSearchItem()
        : SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.padding20,
                vertical: Sizes.padding20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    StringConst.savedSearchTitle,
                    style: TextStyle(
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
  }

  _requestSavedSearch() {
    final employerBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerSaveSearchRequestParams params = EmployerSaveSearchRequestParams(
        token: employerData!['token'], userId: employerData!['user_id']);
    employerBloc.add(EmployerSaveSearchListRequested(params: params));
  }

  void _setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }
}
