part of '../../views.dart';

class ChatRequestSection extends StatefulWidget {
  const ChatRequestSection({super.key});

  @override
  State<ChatRequestSection> createState() => _ChatRequestSectionState();
}

class _ChatRequestSectionState extends State<ChatRequestSection> {
  String route = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  initializeData() {
    if (Get.parameters.isNotEmpty) {
      route = Get.parameters['route'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: BackgroundScaffold(
            onWillPop: () => Get.offAllNamed(rootRoute),
            scaffold: _getChatListScaffold));
  }

  Scaffold get _getChatListScaffold {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _getAppBar,
      drawer: const SideMenu(
        menuName: StringConst.chatTitle,
      ),
      drawerScrimColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      body: _getChatRequestContainer,
    );
  }

  //AppBar
  AppBar get _getAppBar => AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          StringConst.chatRequestText.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w100),
        ),
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: InkWell(
              onTap: () => _scaffoldKey.currentState!.openDrawer(),
              child: Image.asset("assets/icons/menu.png")),
        ),
        leadingWidth: 52,
        elevation: 0.0,
        titleSpacing: 0.0,
        centerTitle: true,
        bottom: TabBar(
          isScrollable: true,
          indicatorColor: AppColors.secondaryColor,
          labelPadding: const EdgeInsets.symmetric(horizontal: 40.0),
          //indicatorSize: TabBarIndicatorSize.label,
          labelColor: AppColors.secondaryColor,
          unselectedLabelColor: AppColors.primaryGrey,
          tabs: [
            Tab(text: StringConst.incomingChatText.tr),
            Tab(
              text: StringConst.yourRequestText.tr,
            ),
          ],
        ),
      );

  Widget get _getChatRequestContainer => const TabBarView(
        children: [IncomingRequestList(), MyRequestList()],
      );
}
