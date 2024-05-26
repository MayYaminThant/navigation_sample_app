part of '../../views.dart';

class RewardSection extends StatefulWidget {
  const RewardSection({super.key});

  @override
  State<RewardSection> createState() => _RewardSectionState();
}

class _RewardSectionState extends State<RewardSection> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String countryName = "";
  bool isLoading = true;
  Map? candidateData = {};
  int _currentCoin = 0;
  String basePhotoUrl = '';
  bool loadMore = false;

  @override
  void initState() {
    _initLoad();
    super.initState();
  }

  Future<void> _initLoad() async {
    await _getCandidateData();
    await _getPhotoUrl();
    _requestRewardsList();
    _getCoinBalance();
  }

  void _loadMoreData() {
    _requestRewardsList();
    setState(() {
      loadMore = true;
    });
  }

  Future<void> _getPhotoUrl() async {
    String data =
        await DBUtils.getCandidateConfigs(DBUtils.stroagePrefix) ?? '';
    if (data != '') {
      setState(() {
        basePhotoUrl = data;
      });
    }
  }

  Future<void> _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    candidateData = box.get(DBUtils.candidateTableName);
    setState(() {
      countryName = box.get(DBUtils.country) ?? '';
    });
  }

  void _getCoinBalance() {
    if (candidateData != null) {
      if (candidateData!['token'] != null) {
        final candidateBloc = BlocProvider.of<CandidateBloc>(context);
        CandidateListCoinBalanceRequestParams params =
            CandidateListCoinBalanceRequestParams(
                token: candidateData!['token']);
        candidateBloc.add(CandidateCoinBalanceListRequested(params: params));
      }
    }
  }

  void _requestRewardsList() {
    final rewardBloc = BlocProvider.of<RewardBloc>(context);
    RewardListRequestParams params = RewardListRequestParams(
        appLocale: countryName,
        page: rewardBloc.loadMorePage,
        bearerToken: candidateData!['token']);
    rewardBloc.add(RewardsListRequested(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return _homeScaffold;
  }

  Widget get _homeScaffold => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BackgroundScaffold(
            scaffold: Scaffold(
                key: _scaffoldKey,
                appBar: _getAppBar,
                drawer: const SideMenu(
                  menuName: StringConst.coinsAndRewardText,
                ),
                drawerScrimColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                body:
                    BlocConsumer<RewardBloc, RewardState>(builder: (_, state) {
                  return _buildRewardList;
                }, listener: (_, state) {
                  if (state is RewardsListLoading) {
                    _setLoading(true);
                  }
                  if (state is RewardsListSuccess) {
                    // loadMore ? _scrollDown() : null;
                    _setLoading(false);
                    setState(() {
                      loadMore = false;
                    });
                  }
                  if (state is RewardsListFail) {
                    _setLoading(false);
                    setState(() {
                      loadMore = false;
                    });
                  }
                }))),
      );
  Widget get _buildRewardList => isLoading
      ? LoadingScaffold.getLoading()
      : Scrollbar(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _getRewardHeader,
                BlocProvider.of<RewardBloc>(context).rewardListModel == null ||
                        BlocProvider.of<RewardBloc>(context)
                            .rewardListModel!
                            .data!
                            .data!
                            .isEmpty
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height - 170,
                        child: const NoRewardItem())
                    : Padding(
                        padding: const EdgeInsets.only(
                            top: 15, left: 20.0, right: 20.0),
                        child: Column(
                          children: [
                            Wrap(
                              children: BlocProvider.of<RewardBloc>(context)
                                  .rewardListModel!
                                  .data!
                                  .data!
                                  .map((e) {
                                final index =
                                    BlocProvider.of<RewardBloc>(context)
                                        .rewardListModel!
                                        .data!
                                        .data!
                                        .indexOf(e);
                                superPrint(
                                    '$basePhotoUrl/${e.imageS3Filepath!}');
                                return RewardCard(
                                  index: index,
                                  title: e.reward!,
                                  description: e.desc!,
                                  imageUrl:
                                      '$basePhotoUrl/${e.imageS3Filepath!}',
                                  itemCount: e.itemCount.toString(),
                                  pHCRequired: e.phcRequired.toString(),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 10),
                            context.read<RewardBloc>().nextPageUrl
                                ? loadMore
                                    ? const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: SizedBox(
                                            width: 17,
                                            height: 17,
                                            child: CircularProgressIndicator(
                                                strokeWidth: 2.0)),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CustomPrimaryButton(
                                          heightButton: 40,
                                          widthButton: 70,
                                          text: 'See More',
                                          onPressed: () => _loadMoreData(),
                                          fontSize: 10,
                                        ),
                                      )
                                : Container(),
                            _buildFooder,
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                // _buildFooder
              ],
            ),
          ),
        );

  void _setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  AppBar get _getAppBar => AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => _scaffoldKey.currentState!.openDrawer(),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Image.asset("assets/icons/menu.png")),
        ),
        leadingWidth: 52,
        title: Text(
          StringConst.rewardTitle.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w100),
        ),
        elevation: 0.0,
        titleSpacing: 0.0,
        centerTitle: true,
      );

  Widget get _getRewardHeader {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23.0),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 7.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 26,
                    height: 26,
                    child: SvgPicture.asset('assets/svg/coin.svg',
                        // ignore: deprecated_member_use
                        color: AppColors.primaryColor),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  BlocConsumer<CandidateBloc, CandidateState>(
                    builder: (context, state) => Text(
                      '$_currentCoin Coins',
                      style: const TextStyle(
                        fontSize: 15,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    listener: (context, state) {
                      if (state is CandidateCoinBalanceListLoading) {}
                      if (state is CandidateCoinBalanceListSuccess) {
                        if (state.data.data != null) {
                          setState(() {
                            _currentCoin = state.data.data!["data"];
                          });
                        }
                      }
                      if (state is CandidateCoinBalanceListFail) {}
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 174.54,
              height: 50,
              child: CountryDropdownItem(
                  initialValue: countryName,
                  topCountries: const [],
                  title: 'Country',
                  onValueChanged: (String value) {
                    setState(() {
                      countryName = value;
                    });
                    final rewardBloc = BlocProvider.of<RewardBloc>(context);
                    rewardBloc.resetState();
                    _requestRewardsList();
                  },
                  prefix: ConfigsKeyHelper.rewardCountryKey),
            )
          ]),
    );
  }

  Widget get _buildFooder => const Text(
        "*Rewards Redemption can only occur once every 48 hours.",
        textAlign: TextAlign.center,
        style: TextStyle(color: Color(0xFFBEBEBE), height: 2.5),
      );
}
