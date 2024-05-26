part of '../../views.dart';

class ApplicationStatusSection extends StatefulWidget {
  const ApplicationStatusSection({Key? key}) : super(key: key);

  @override
  State<ApplicationStatusSection> createState() =>
      _ApplicationStatusSectionState();
}

class _ApplicationStatusSectionState extends State<ApplicationStatusSection> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  int _currentPage = 0;
  final PageController _pageController = PageController();
  final pageCount = 4;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/no-image-bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
            key: _scaffoldKey,
            appBar: _buildAppBar(),
            backgroundColor: Colors.transparent,
            body: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              pageSnapping: true,
              children: List.generate(
                pageCount,
                (index) => _getApplicationStatusContainer(),
              ),
            )

            //_getApplicationStatusContainer(),
            ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: InkWell(
          onTap: () => _scaffoldKey.currentState!.openDrawer(),
          child: Image.asset("assets/icons/menu.png"),
        ),
      ),
      leadingWidth: 52,
      title: const Text(
        'Application Status',
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      elevation: 0.0,
      titleSpacing: 0.0,
      centerTitle: true,
      actions: [
        _buildActiveStatus(),
        _buildNotification(),
      ],
    );
  }

  Widget _buildActiveStatus() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.padding4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 7.0,
            height: 7.0,
            decoration: const BoxDecoration(
              color: AppColors.green,
              borderRadius: BorderRadius.all(Radius.circular(3.5)),
            ),
          ),
          const SizedBox(
            width: 47,
            height: 30,
            child: Text(
              "Available to work",
              style: TextStyle(color: AppColors.white, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotification() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Stack(
          children: [
            SizedBox(
              width: 36.0,
              height: 36.0,
              child: Image.asset('assets/icons/noti.png'),
            ),
            const SizedBox(
              width: 10,
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 20.0,
                height: 20.0,
                decoration: const BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: const Center(
                  child: Text(
                    '3',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getApplicationStatusContainer() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.padding32,
          vertical: Sizes.padding20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _getApplicationListView(),
            const Text(
              'Here are your interviews.',
              style: TextStyle(color: AppColors.primaryGrey),
            ),
            const CardGradient(
              isCanceled: false,
            ),
            const CardGradient(
              isCanceled: false,
            ),
            const CardGradient(
              isCanceled: true,
            ),
            const CardGradient(
              isCanceled: false,
            ),
            const CardGradient(
              isCanceled: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getApplicationListView() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: SizedBox(
        height: 40,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            _buildOption('Interviews', index: 0),
            _buildOption('Applied', index: 1),
            _buildOption('Requested', index: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(String text, {required int index}) {
    final isSelected = index == _selectedIndex;
    final color = isSelected ? Colors.white : AppColors.primaryGrey;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
