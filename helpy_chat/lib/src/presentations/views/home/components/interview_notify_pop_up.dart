import 'package:dh_mobile/src/presentations/values/values.dart';
import 'package:flutter/material.dart';

class InterviewNotifyPopUp extends StatelessWidget {
  const InterviewNotifyPopUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 327,
        height: 226,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              '''Time's Up!''',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.greyShade2,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Interviews can last for a maximum of 1 hour.\nThank you for your time!',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.greyShade2,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: Text(
                '04:32',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: AppColors.greyShade2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
