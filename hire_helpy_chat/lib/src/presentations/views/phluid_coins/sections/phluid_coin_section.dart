part of '../../views.dart';

class PhluidVoucherSection extends StatefulWidget {
  const PhluidVoucherSection({super.key});

  @override
  State<PhluidVoucherSection> createState() => _PhluidVoucherSectionState();
}

class _PhluidVoucherSectionState extends State<PhluidVoucherSection> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map? employerData;
  List<VoucherHistory> voucherHistoryList = [];
  bool isLoading = false;
  bool coinBalanceLoading = false;
  int totalCoins = 0;

  @override
  void initState() {
    _getCandidateData();
    super.initState();
  }

  _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    employerData = box.get(DBUtils.employerTableName);
    if (employerData != null &&
        employerData![DBUtils.employerTableName] != null) {
      _requestCoinHistoryList();
    }
  }

  _requestCoinHistoryList() {
    final articleBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerListVoucherHistoryRequestParams params =
        EmployerListVoucherHistoryRequestParams(
      token: employerData!['token'],
      userId: employerData!['user_id'],
    );
    articleBloc.add(EmployerVoucherHistoryListRequested(params: params));
  }

  _requestCoinBalance() {
    final articleBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerCoinBalanceRequestParams params = EmployerCoinBalanceRequestParams(
      token: employerData!['token'],
      userId: employerData!['user_id'],
    );
    articleBloc.add(EmployerCoinBalanceRequested(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployerBloc, EmployerState>(builder: (_, state) {
      return _getPhluidCoinScaffold;
    }, listener: (_, state) {
      if (state is EmployerCoinHistoryListLoading) {
        _setLoading(true);
      }

      if (state is EmployerCoinHistoryListSuccess) {
        _setLoading(false);
        if (state.data.data != null) {
          var datas = state.data.data!['data'];

          List<VoucherHistory> data = List<VoucherHistory>.from(
              (datas['data'] as List<dynamic>).map((e) =>
                  VoucherHistoryModel.fromJson(e as Map<String, dynamic>)));
          setState(() {
            voucherHistoryList = data;
            totalCoins = datas['total_coin'] ?? 0;
          });
          employerData!['p_coin'] = totalCoins;
          DBUtils.saveNewData(
              {'data': employerData}, DBUtils.employerTableName);
        }
      }

      if (state is EmployerCoinHistoryListFail) {
        _setLoading(false);
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  Widget get _getPhluidCoinScaffold {
    return Stack(
      children: [
        BackgroundScaffold(
            onWillPop: () => Get.offAllNamed(rootRoute),
            scaffold: isLoading
                ? LoadingScaffold.getLoading()
                : Scaffold(
                    key: _scaffoldKey,
                    appBar: _getAppBar,
                    drawer: const SideMenu(
                      menuName: StringConst.phluidCoinText,
                    ),
                    drawerScrimColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    body: _getPhluidCoinContainer,
                  )),
      ],
    );
  }

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
        StringConst.phluidCoinText,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      elevation: 0.0,
      titleSpacing: 0.0,
      centerTitle: true,
    );
  }

  Widget get _getPhluidCoinContainer {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.padding20,
          vertical: Sizes.padding20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _getPhluidCoinHeader,
            voucherHistoryList.isNotEmpty
                ? _getPhluidCoinList
                : const CoinEmptyList(),
          ],
        ),
      ),
    );
  }

  Widget get _getPhluidCoinHeader {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Current Balance',
                style: TextStyle(
                    fontSize: 20,
                    color: AppColors.white,
                    fontWeight: FontWeight.w600),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.black.withOpacity(0.3)),
                child: Text(
                  '$totalCoins Coins',
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget get _getPhluidCoinList {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        ListView.builder(
          shrinkWrap: true,
          itemCount: voucherHistoryList.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return CoinItem(coinHistory: voucherHistoryList[index]);
          },
        ),
      ],
    );
  }

  void _setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }
}
