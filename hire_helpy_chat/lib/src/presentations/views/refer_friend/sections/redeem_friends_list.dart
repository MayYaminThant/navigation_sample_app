part of '../../views.dart';

class RedeemFriendsSection extends StatefulWidget {
  const RedeemFriendsSection({super.key});

  @override
  State<RedeemFriendsSection> createState() => _RedeemFriendsSectionState();
}

class _RedeemFriendsSectionState extends State<RedeemFriendsSection> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController searchController = TextEditingController();
  List<kFlutterContacts.Contact> contactList = [];
  Map? candidateData;
  List<ReferFriend> referFriendList = [];
  List<Config> configList = [];
  bool isLoading = false;

  @override
  void initState() {
    _getCandidateData();
    _getConfigsData();
    super.initState();
  }

  void _getConfigsData() async {
    List<Config> data = List<Config>.from(
        (await DBUtils.getEmployerConfigs('configs'))
            .map((e) => ConfigModel.fromJson(e)));

    setState(() {
      configList.addAll(data);
    });
  }

  _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    candidateData = box.get(DBUtils.employerTableName);
    if (candidateData != null) {
      _requestReferFrienList();
    }
  }

  _requestReferFrienList() {
    final articleBloc = BlocProvider.of<EmployerBloc>(context);
    EmployerReferFriendRequestParams params =
        EmployerReferFriendRequestParams(
      token: candidateData!['token'],
      userId: candidateData!['user_id'],
    );
    articleBloc.add(EmployerReferFriendListRequested(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployerBloc, EmployerState>(builder: (_, state) {
      return _getReferFriendScaffold;
    }, listener: (_, state) {
      if (state is EmployerReferFriendListLoading) {
        _setLoading(true);
      }

      if (state is EmployerReferFriendListSuccess) {
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

      if (state is EmployerReferFriendListFail) {
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
      child: 
            _getReferFriendContactList,
    );
  }

  Widget get _getReferFriendContactList {
    return referFriendList.isEmpty
        ? _buildNoContactsText()
        : Scrollbar(
          child: Container(
            padding: const EdgeInsets.symmetric(
            horizontal: Sizes.padding20,
            vertical: Sizes.padding20,
            ),
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
          ),
        );
  }

  Widget _buildNoContactsText() {
    return const EmptyMessage(
      title: 'No Referral Friends!',
      image: 'assets/images/empty-refer.png',
      description: Text.rich(
        TextSpan(
          children: [
            TextSpan(
                text:
                    "Unleash the power of friendship! When your friends get to the app by installing and registering through your link, claim your vouchers. Just remember to log in and watch those shiny treasures fill your account!",
                style: TextStyle(
                    fontSize: 14, color: AppColors.primaryGrey, height: 2)),
          ],
        ),
        textAlign: TextAlign.center,
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
