import 'package:flutter/material.dart';

import '../../../values/values.dart';

class CoinEmptyList extends StatelessWidget {
  const CoinEmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 40,),

        Container(
              height: 200,
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: AppColors.backgroundGrey.withOpacity(0.1)
              ),
              child: Image.asset('assets/images/empty-coins.png'),
            ),
        const SizedBox(height: 20,),
        const Text(
          'You don’t have any coins yet! ',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12), // Espaço entre os textos
        DefaultTextStyle.merge(
          style: const TextStyle(color: Colors.white, fontSize: 15, height: 2,),
          child: RichText(
            text: const TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: 'Collect by completing ',
                  style: TextStyle(color: Colors.grey, height: 2, fontSize: 14),
                ),
                TextSpan(
                  text: 'Profile',
                  style: TextStyle(color: Colors.orange, fontSize: 14),
                ),
                TextSpan(
                  text: ' or \n',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                TextSpan(
                  text: '      Referring',
                  style: TextStyle(color: Colors.orange, height: 2, fontSize: 14),
                ),
                TextSpan(
                  text: ' to your friends!',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
