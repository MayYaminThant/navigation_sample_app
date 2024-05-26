
import 'package:flutter/material.dart';

import '../../../values/values.dart';

class MenuDivider extends StatelessWidget {
  const MenuDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return _getDivider;
  }

  //Divider
  Widget get _getDivider {
    return const Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: Divider(
        color: AppColors.primaryGrey,
        height: 0.5,
      ),
    );
  }

}