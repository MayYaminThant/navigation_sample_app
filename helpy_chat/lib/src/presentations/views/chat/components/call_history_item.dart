import 'package:flutter/material.dart';

import '../../../values/values.dart';

class CallHistoryItem extends StatefulWidget {
  const CallHistoryItem({super.key});

  @override
  State<CallHistoryItem> createState() => _CallHistoryItemState();
}

class _CallHistoryItemState extends State<CallHistoryItem> {

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage:
                  AssetImage('assets/images/employer_star_list.png'),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: const Text(
                        'Jane Dose',
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                const SizedBox(
                  height: 5.0,
                ),
                const Text(
                  '19/07/2023',
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w200),
                ),
              ],
            )
          ],
        ),
      );
  }
}
