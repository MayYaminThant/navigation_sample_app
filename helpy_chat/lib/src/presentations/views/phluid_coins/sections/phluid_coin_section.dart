part of '../../views.dart';

class PhluidCoinSection extends StatefulWidget {
  const PhluidCoinSection({super.key});

  @override
  State<PhluidCoinSection> createState() => _PhluidCoinSectionState();
}

class _PhluidCoinSectionState extends State<PhluidCoinSection> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map? candidateData;
  List<CoinHistory> coinHistoryList = [];
  bool isLoading = true;
  int totalCoins = 0;

  @override
  void initState() {
    _getCandidateData();
    super.initState();
  }

  _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    candidateData = box.get(DBUtils.candidateTableName);
    if (candidateData != null) {
      _requestCoinHistoryList();
    }
    _getCoinBalance();
  }

  Future<void> _getCoinBalance() async {
    if (candidateData!['token'] != null) {
      final candidateBloc = BlocProvider.of<CandidateBloc>(context);
      CandidateListCoinBalanceRequestParams params =
          CandidateListCoinBalanceRequestParams(token: candidateData!['token']);
      candidateBloc.add(CandidateCoinBalanceListRequested(params: params));
    }
  }

  _requestCoinHistoryList() {
    final articleBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateListCoinHistoryRequestParams params =
        CandidateListCoinHistoryRequestParams(
      token: candidateData!['token'],
      userId: candidateData!['user_id'],
    );
    articleBloc.add(CandidateCoinHistoryListRequested(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CandidateBloc, CandidateState>(builder: (_, state) {
      return _getPhluidCoinScaffold;
    }, listener: (_, state) {
      if (state is CandidateCoinHistoryListLoading) {
        _setLoading(true);
      }
      if (state is CandidateCoinHistoryListSuccess) {
        _setLoading(false);
        if (state.data.data != null) {
          var datas = state.data.data!['data'];

          List<CoinHistory> data = List<CoinHistory>.from(
              (datas['data'] as List<dynamic>).map(
                  (e) => CoinHistoryModel.fromJson(e as Map<String, dynamic>)));
          setState(() {
            coinHistoryList = data;
            totalCoins = datas['total_coin'];
          });
          candidateData!['p_coin'] = totalCoins;
          DBUtils.saveNewData(
              {'data': candidateData}, DBUtils.candidateTableName);
        }
      }

      if (state is CandidateCoinHistoryListFail) {
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
      title: Text(
        StringConst.phluidCoinText.tr,
        style: const TextStyle(
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
      physics:const BouncingScrollPhysics(),
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
            coinHistoryList.isNotEmpty
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
               Text(
                StringConst.currentBalanceText.tr,
                style: const TextStyle(
                    fontSize: 20,
                    color: AppColors.white,
                    fontWeight: FontWeight.w600),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.black.withOpacity(0.3)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: SvgPicture.asset('assets/svg/coin.svg',
                          // ignore: deprecated_member_use
                          color: AppColors.primaryColor),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '$totalCoins Coins',
                      style: const TextStyle(
                        fontSize: 15,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget get _getPhluidCoinList {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: coinHistoryList.map((e) => CoinItem(coinHistory: e)).toList(),
    );
  }

  void _setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }
}
