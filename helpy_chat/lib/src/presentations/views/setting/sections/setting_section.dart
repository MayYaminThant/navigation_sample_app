part of '../../views.dart';

class SettingSection extends StatefulWidget {
  const SettingSection({Key? key}) : super(key: key);

  @override
  State<SettingSection> createState() => _SettingSectionState();
}

class _SettingSectionState extends State<SettingSection> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isEmailNotificationEnabled = false;
  bool isAppNotificationEnabled = false;
  bool isProfileVisibilityEnabled = false;
  bool isPrivateAccountEnabled = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Stack(
        children: [
          Container(
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
              drawer: const SideMenu(
                menuName: StringConst.settingsText,
              ),
              drawerScrimColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              body: _buildSettingContainer(),
            ),
          ),
        ],
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
        'Settings',
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
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingContainer() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildHeader('assets/icons/usertick.png', 'Account'),
            const Divider(color: AppColors.articleBackgroundColor),
            const CustomExpansionTile(
              email: 'teste@phluid.world',
              phoneNumber: '+55 999212941',
              changePassword: 'password',
            ),
            _buildHeader('assets/icons/noti.png', 'Notifications'),
            const Divider(color: AppColors.articleBackgroundColor),
            _buildSwitchRow(
              'Email Notification',
              isEmailNotificationEnabled,
              (value) {
                setState(() {
                  isEmailNotificationEnabled = value;
                });
              },
            ),
            _buildSwitchRow(
              'App Notification',
              isAppNotificationEnabled,
              (value) {
                setState(() {
                  isAppNotificationEnabled = value;
                });
              },
            ),
            _buildHeader('assets/icons/more.png', 'More'),
            const Divider(color: AppColors.articleBackgroundColor),
            _buildSwitchRow(
              'Profile Visibility',
              isProfileVisibilityEnabled,
              (value) {
                setState(() {
                  isProfileVisibilityEnabled = value;
                });
              },
            ),
            _buildSwitchRow(
              'Private Account',
              isPrivateAccountEnabled,
              (value) {
                setState(() {
                  isPrivateAccountEnabled = value;
                });
              },
            ),
            const SizedBox(height: 100),
            InkWell(
              onTap: () {},
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: AppColors.cardColor.withOpacity(0.1),
                  height: 36,
                  width: 144,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset('assets/icons/logout_orange.png'),
                      const Text(
                        "Log Out",
                        style: TextStyle(fontSize: 12, color: AppColors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String logo, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        children: [
          SizedBox(height: 24, width: 24, child: Image.asset(logo)),
          const SizedBox(width: 15),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchRow(String label, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w100,
            fontSize: 12,
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.green,
          inactiveThumbColor: Colors.grey,
          inactiveTrackColor: AppColors.greyShade2,
          thumbColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.white;
              }
              return Colors.grey;
            },
          ),
        ),
      ],
    );
  }
}
