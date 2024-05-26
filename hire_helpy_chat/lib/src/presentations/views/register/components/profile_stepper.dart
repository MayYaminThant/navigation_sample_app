import 'package:flutter/material.dart';

import '../../../values/values.dart';

class ProfileStepper extends StatelessWidget {
  const ProfileStepper({super.key, required this.currentIndex});
  final int currentIndex;

  final int count = 3;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 30,
          child: ListView.builder(
              itemCount: count,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return  currentIndex >= index ? _getStepItem(index): _getStepDots();
              }),
        ),
      ],
    );
  }

  _getStepItem(int index) {
    return Row(
      children: [
        
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15.0),
          width: 30,
          height: 30,
          decoration: BoxDecoration(
             border: Border.all(color: AppColors.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(15)),
          child: Center(
              child: Text(
            '${index + 1}',
            style: const TextStyle(color: AppColors.primaryColor),
          )),
        ),
        if(index != currentIndex) const Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text('......', style: TextStyle(color: AppColors.primaryColor, fontSize: 16),),
        ),
      ],
    );
  }


  _getStepDots() {
    return Row(
      children: [
        const Padding(
          padding:  EdgeInsets.only(bottom: 10.0),
          child: Text('......', style: TextStyle(color: AppColors.primaryColor, fontSize: 16),),
        ),
        Container(
          //margin: const EdgeInsets.symmetric(horizontal: 10.0),
          margin: const EdgeInsets.all(10.0),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(7.5)
              ),
        ),
      ],
    );
  }
}
