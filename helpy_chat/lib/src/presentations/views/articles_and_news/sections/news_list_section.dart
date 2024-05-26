part of '../../views.dart';

class NewsListSection extends StatefulWidget {
  const NewsListSection({super.key});

  @override
  State<NewsListSection> createState() => _NewsListSectionState();
}

class _NewsListSectionState extends State<NewsListSection> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BackgroundScaffold(
      onWillPop: () async {
        _requestInitialize();
        Get.offAllNamed(rootRoute);
        return false;
      },
      scaffold: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/no-image-bg.png'),
                  fit: BoxFit.cover)),
          child: Scaffold(
            key: _scaffoldKey,
            appBar: _getAppBar,
            drawerScrimColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            drawer: const SideMenu(
              menuName: StringConst.articlesList,
            ),
            body: _getEventListContainer,
          ),
        ),
      ),
    );
  }

  AppBar get _getAppBar {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () {
          _requestInitialize();
          Get.offAllNamed(rootRoute);
        },
        child: const Icon(
          Iconsax.arrow_left,
          color: AppColors.white,
        ),
      ),
      title: const Text(
        'Adventures',
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.white),
      ),
      leadingWidth: 52,
      elevation: 0.0,
      titleSpacing: 0.0,
      centerTitle: true,
    );
  }

  Widget get _getEventListContainer {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.padding20,
        ),
        child: const NewList(),
      ),
    );
  }

  _requestInitialize() {
    final articleBloc = BlocProvider.of<ArticleBloc>(context);
    articleBloc.add(InitializeArticleEvent());
  }
}
