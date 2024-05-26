import 'package:flutter/material.dart';

import '../../../values/values.dart';

class EmptySearchResultItem extends StatefulWidget {
  const EmptySearchResultItem({super.key});

  @override
  State<EmptySearchResultItem> createState() => _EmptySearchResultItemState();
}

class _EmptySearchResultItemState extends State<EmptySearchResultItem> {
  @override
  Widget build(BuildContext context) {
    return _getEmptySearchResult;
  }

  Widget get _getEmptySearchResult => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: Image.asset('assets/images/empty-result.png'),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              StringConst.noSearchResultText,
              style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                StringConst.noSearchResultDesc,
                style: TextStyle(
                    color: AppColors.primaryGrey,
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                    height: 2),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      );
}
