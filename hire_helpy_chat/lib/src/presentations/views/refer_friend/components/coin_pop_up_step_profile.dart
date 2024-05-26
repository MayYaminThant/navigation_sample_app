import 'package:dh_employer/src/presentations/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CoinPopupStepProfile extends StatelessWidget {
  const CoinPopupStepProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          height: 205,
          width: 328,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              CustomImageView(
                imagePath: "assets/images/phluid_logo.png",
              ),
              Text(
                'Congratulations!',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              Text(
                'You have received 25 Phluid Coins\nfor completing 1 step of Profile',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
