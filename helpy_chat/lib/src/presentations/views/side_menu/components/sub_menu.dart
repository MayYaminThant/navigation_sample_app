import 'package:dh_mobile/src/config/routes/routes.dart';
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
  Map? candidateData;

  @override
  void initState() {
    _getCandidateData();
    super.initState();
  }

  Future<void> _getCandidateData() async {
    Box box = await Hive.openBox(DBUtils.dbName);
    setState(() {
      candidateData = box.get(DBUtils.candidateTableName);
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
          GestureDetector(
            behavior: HitTestBehavior.opaque,
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
            style: const TextStyle(
                height: 1, fontSize: 16, color: AppColors.primaryGrey),
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
    behavior: HitTestBehavior.opaque,
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
    behavior: HitTestBehavior.opaque,
        onTap: () => _clickSideMenu(name),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: Get.locale!.countryCode == 'US' ? 13.0 : 11.0,
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
                        height: 1.6,
                        fontSize: 16,
                        color: AppColors.primaryGrey),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  //Click Side Menu
  void _clickSideMenu(String name) {
    if (candidateData == null) {
      _checkEmptyPage(name);
    } else if (name == widget.mainMenuName) {
      Navigator.pop(context);
    } else {
      switch (name) {
        //Chat Setting
        case StringConst.chatTitle:
          Get.offNamed(chatListPageRoute);
          break;

        case StringConst.chatRequestText:
          Get.offNamed(requestChatPageRoute);
          break;

        //Account Setting
        case StringConst.myAccountText:
          Get.offNamed(myAccountPageRoute);
          break;

        case StringConst.profileDetailsText:
          Get.offNamed(dhProfilePageRoute);
          break;

        //Coins And Reward
        case StringConst.phluidCoinText:
          Get.offNamed(phluidCoinsPageRoute);
          break;

        case StringConst.rewardTitle:
          Get.offNamed(rewardPageRoute);
          break;

        default:
          Get.offAllNamed(signInPageRoute);
          break;
      }
    }
  }

  void _checkEmptyPage(String name) {
    switch (name) {
      case StringConst.phluidCoinText:
        Get.offNamed(nonLoginInfoPageRoute, parameters: {'name': name});
        break;
      case StringConst.myAccountText:
        Get.offNamed(nonLoginInfoPageRoute, parameters: {'name': name});
        break;
      case StringConst.profileDetailsText:
        Get.offNamed(nonLoginInfoPageRoute, parameters: {'name': name});
        break;
      case StringConst.chatTitle:
        Get.offNamed(nonLoginInfoPageRoute, parameters: {'name': name});
        break;
      case StringConst.chatRequestText:
        Get.offNamed(nonLoginInfoPageRoute, parameters: {'name': name});
        break;
      case StringConst.rewardTitle:
        Get.offNamed(nonLoginInfoPageRoute, parameters: {'name': name});
        break;
      default:
        Get.offAllNamed(signInPageRoute);
        break;
    }
  }
}
