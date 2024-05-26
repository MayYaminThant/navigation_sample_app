import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({super.key, required this.icon, required this.name, required this.iconColor, required this.textColor,  required this.isMoreSetting});
  final IconData icon;
  final String name;
  final Color iconColor;
  final Color textColor;
  final bool isMoreSetting;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Get.locale!.countryCode == 'US'  ? 13.0: 11.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 26,
                height: 26,
                child: Icon(
                  icon,
                  color: iconColor,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 170,
                child: Text(
                  name.tr,
                  style: TextStyle(
                    height: 1.2,
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: textColor),
                ),
              ),
            ],
          ),
          isMoreSetting ? _getForwardIcon(name) : Container(),
        ],
      ),
    );
  }

  //Forward Menu Icon
  Icon _getForwardIcon(String name) => Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: iconColor,
      );
}
