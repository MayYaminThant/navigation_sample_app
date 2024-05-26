import 'package:dh_employer/src/config/routes/routes.dart';
import 'package:dh_employer/src/presentations/widgets/super_print.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/utils/db_utils.dart';
import '../../../values/values.dart';
import 'menu_divider.dart';
import 'menu_item.dart';

class SubMenuItem extends StatefulWidget {
  const SubMenuItem(
      {super.key, required this.mainMenuName, required this.onValueChanged});
  final String mainMenuName;
  final ValueChanged<bool> onValueChanged;

  @override
  State<SubMenuItem> createState() => _SubMenuItemState();
}

class _SubMenuItemState extends State<SubMenuItem> {
  Map? employerData;

  @override
  void initState() {
    _getEmployerData();
    super.initState();
  }

  _getEmployerData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      employerData = box.get(DBUtils.employerTableName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_getSubMenuHeader, const MenuDivider(), _getSubMenuItems()],
    );
  }

  get _getSubMenuHeader => Row(
        children: [
          InkWell(
            onTap: () => widget.onValueChanged(false),
            child: const SizedBox(
              width: 26,
              height: 26,
              child: Icon(
                Iconsax.arrow_left,
                color: AppColors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            widget.mainMenuName.tr,
            style: const TextStyle(fontSize: 16, color: AppColors.primaryGrey),
          ),
        ],
      );

  //SubMenu Items
  _getSubMenuItems() {
    switch (widget.mainMenuName) {
      case StringConst.accountSettingText:
        return _getAccountMenus;
      case StringConst.chatSettingText:
        return _getChatMenus;
      case StringConst.coinsAndRewardText:
        return _getCoinsRewardMenus;
      default:
        return Container();
    }
  }

  //Account Menu
  get _getAccountMenus => Column(
        children: [
          _getMenuItem(
            Iconsax.profile_circle,
            StringConst.myAccountText,
          ),
          _getMenuItem(
            Iconsax.profile_circle,
            StringConst.profileDetailsText,
          )
        ],
      );

  //Chat Menu
  get _getChatMenus => Column(
        children: [
          _getMenuItem(
            Iconsax.messages,
            StringConst.chatTitle,
          ),
          _getMenuItem(
            Iconsax.message_add,
            StringConst.chatRequestText,
          )
        ],
      );

  //Chat Menu
  get _getCoinsRewardMenus => Column(
        children: [
          _getPhluidCoinMenuItems(
            StringConst.phluidCoinText,
          ),
          _getMenuItem(
            Iconsax.gift,
            StringConst.rewardTitle,
          )
        ],
      );

  //Menu Item
  Widget _getMenuItem(IconData icon, String name) => GestureDetector(
        onTap: () => _clickSideMenu(name),
        child: MenuItem(
          icon: icon,
          name: name,
          iconColor: AppColors.white,
          textColor: AppColors.primaryGrey,
          isMoreSetting: false,
        ),
      );

  //Menu Items
  Widget _getPhluidCoinMenuItems(String name) => GestureDetector(
        onTap: () => _clickSideMenu(name),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 13.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 26,
                    height: 26,
                    child: SvgPicture.asset(
                      'assets/svg/coin.svg',
                      // ignore: deprecated_member_use
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                        height: 1, fontSize: 16, color: AppColors.primaryGrey),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  //Click Side Menu
  _clickSideMenu(String name) {
    if (employerData == null) {
      _checkEmptyPage(name);
    } else if (name == widget.mainMenuName) {
      Navigator.pop(context);
    } else {
      switch (name) {
        //Chat Setting
        case StringConst.chatTitle:
          Get.toNamed(chatListPageRoute);
          break;

        case StringConst.chatRequestText:
          Get.toNamed(requestChatPageRoute);
          break;

        //Account Setting
        case StringConst.myAccountText:
          Get.toNamed(myAccountPageRoute);
          break;

        case StringConst.profileDetailsText:
          Get.toNamed(dhProfilePageRoute);
          break;

        //Coins And Reward
        case StringConst.phluidCoinText:
          Get.toNamed(phluidCoinsPageRoute);
          break;

        case StringConst.rewardTitle:
          Get.toNamed(rewardPageRoute);
          break;
      }
    }
  }

  void _checkEmptyPage(String name) {
    superPrint(name);
    switch (name) {
      case StringConst.phluidCoinText:
        Get.toNamed(nonLoginInfoPageRoute, parameters: {'name': name});
        break;

      case StringConst.chatTitle:
        Get.toNamed(nonLoginInfoPageRoute, parameters: {'name': name});
        break;
      case StringConst.chatRequestText:
        Get.toNamed(nonLoginInfoPageRoute, parameters: {'name': name});
        break;
      case StringConst.myAccountText:
        Get.toNamed(nonLoginInfoPageRoute, parameters: {'name': name});
        break;
      case StringConst.profileDetailsText:
        Get.toNamed(nonLoginInfoPageRoute, parameters: {'name': name});
        break;
      case StringConst.rewardTitle:
        Get.toNamed(nonLoginInfoPageRoute, parameters: {'name': name});
        break;

      default:
        Get.toNamed(signInPageRoute);
    }
  }
}
