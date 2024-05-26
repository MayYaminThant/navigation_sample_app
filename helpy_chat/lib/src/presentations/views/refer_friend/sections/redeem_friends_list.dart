part of '../../views.dart';

class RedeemFriendsSection extends StatefulWidget {
  const RedeemFriendsSection({super.key});

  @override
  State<RedeemFriendsSection> createState() => _RedeemFriendsSectionState();
}

class _RedeemFriendsSectionState extends State<RedeemFriendsSection> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController searchController = TextEditingController();
  List<k_flutter_contacts.Contact> contactList = [];
  Map? candidateData;
  List<ReferFriend> referFriendList = [];
  List<Config> configList = [];
  bool isLoading = true;

  @override
  void initState() {
    _getCandidateData();
    _getConfigsData();
    super.initState();
  }

  void _getConfigsData() async {
    List<Config> data = List<Config>.from(
        (await DBUtils.getCandidateConfigs('configs'))
            .map((e) => ConfigModel.fromJson(e)));

    setState(() {
      configList.addAll(data);
    });
  }

  _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    candidateData = box.get(DBUtils.candidateTableName);
    if (candidateData != null) {
      _requestReferFrienList();
    }
  }

  _requestReferFrienList() {
    final articleBloc = BlocProvider.of<CandidateBloc>(context);
    CandidateReferFriendRequestParams params =
        CandidateReferFriendRequestParams(
      token: candidateData!['token'],
      userId: candidateData!['user_id'],
    );
    articleBloc.add(CandidateReferFriendListRequested(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CandidateBloc, CandidateState>(builder: (_, state) {
      return _getReferFriendScaffold;
    }, listener: (_, state) {
      if (state is CandidateReferFriendListLoading) {
        _setLoading(true);
      }

      if (state is CandidateReferFriendListSuccess) {
        _setLoading(false);
        if (state.data.data != null) {
          var datas = state.data.data!['data'];

          List<ReferFriend> data = List<ReferFriend>.from(
              (datas as List<dynamic>).map(
                  (e) => ReferFriendModel.fromJson(e as Map<String, dynamic>)));
          setState(() {
            referFriendList = data;
          });
        }
      }

      if (state is CandidateReferFriendListFail) {
        _setLoading(false);
        if (state.message != '') {
          showErrorSnackBar(state.message);
        }
      }
    });
  }

  Widget get _getReferFriendScaffold {
    return BackgroundScaffold(
        scaffold: isLoading
            ? LoadingScaffold.getLoading()
            : Scaffold(
                key: _scaffoldKey,
                appBar: _getAppBar,
                drawer: const SideMenu(
                  menuName: StringConst.referToFriendsText,
                ),
                drawerScrimColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                body: _getReferFriendContainer,
              ));
  }

  AppBar get _getAppBar {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: const Icon(
          Iconsax.arrow_left,
          color: AppColors.white,
        ),
      ),
      leadingWidth: 52,
      title: const Text(
        StringConst.referToFriendsText,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      elevation: 0.0,
      titleSpacing: 0.0,
      centerTitle: true,
    );
  }

  Widget get _getReferFriendContainer {
    return SingleChildScrollView(
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
            _getReferFriendContactList,
          ],
        ),
      ),
    );
  }

  Widget get _getReferFriendContactList {
    return referFriendList.isEmpty
        ? _buildNoContactsText()
        : Scrollbar(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: referFriendList.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ReferFriendItem(
                    referFriend: referFriendList[index],
                    coin: _getReferCodeFromConfig(kReferalCoinReward));
              },
            ),
          );
  }

  Widget _buildNoContactsText() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: const Center(
        child: Text(
          'No referral list.',
          style: TextStyle(color: AppColors.white, fontSize: 15),
        ),
      ),
    );
  }

  String _getReferCodeFromConfig(String name) {
    return configList.indexWhere((f) => f.name.toString() == name) != -1
        ? configList[configList.indexWhere((f) => f.name.toString() == name)]
            .value
            .toString()
        : '0';
  }

  void _setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }
}
