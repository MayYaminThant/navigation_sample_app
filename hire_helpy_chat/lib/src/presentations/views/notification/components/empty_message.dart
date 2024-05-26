import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../values/values.dart';

class EmptyMessage extends StatelessWidget {
  const EmptyMessage(
      {super.key,
      required this.title,
      required this.image,
      required this.description,
      this.padding
      });
  final String title;
  final String image;
  final Widget description;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return _getEmptyMessage(context);
  }

  _getEmptyMessage(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: AppColors.backgroundGrey.withOpacity(0.1)),
              child: Container(
                margin: padding != null ?EdgeInsets.all(padding!): EdgeInsets.zero,
                child: Image.asset(image,),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              title.tr,
              style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20),
            ),
            const SizedBox(
              height: 30,
            ),
            description
          ],
        ),
      );
}
