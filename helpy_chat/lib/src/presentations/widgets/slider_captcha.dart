import 'package:dh_mobile/src/presentations/views/recaptcha/slider_lib.dart';
import 'package:flutter/material.dart';

import '../values/values.dart';

class PhluidSliderCaptch extends StatefulWidget {
  const PhluidSliderCaptch({super.key, required this.onValueChanged});
  final ValueChanged<bool> onValueChanged;

  @override
  State<PhluidSliderCaptch> createState() => _PhluidSliderCaptchState();
}

class _PhluidSliderCaptchState extends State<PhluidSliderCaptch> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SizedBox(
        width: double.infinity,
        height: 275,
        child: SliderCaptcha(
          image: Image.asset(
            'assets/images/happy_dh2.jpg',
            fit: BoxFit.fitWidth,
          ),
          colorBar: AppColors.primaryColor,
          colorCaptChar: AppColors.primaryColor,
          title: "Slide to Captcha",
          onConfirm: (value) async {
            widget.onValueChanged(value);
          },
        ),
      ),
    );
  }
}
