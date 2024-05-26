import 'package:dh_employer/src/presentations/values/values.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class OTPField extends StatefulWidget {
  const OTPField({Key? key, required this.controller}) : super(key: key);
  final TextEditingController controller;

  @override
  _OTPFieldState createState() => _OTPFieldState();

  @override
  String toStringShort() => 'Rounded Filled';
}

class _OTPFieldState extends State<OTPField> {
  final focusNode = FocusNode();

  @override
  void dispose() {
    widget.controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  bool showError = false;

  @override
  Widget build(BuildContext context) {
    const length = 6;
    const borderColor = Colors.transparent;
    const errorColor = Color.fromRGBO(255, 234, 238, 1);
    Color fillColor = AppColors.cardColor.withOpacity(0.1);
    final defaultPinTheme = PinTheme(
      width: 43,
      height: 43,
      textStyle: GoogleFonts.poppins(
        fontSize: 15,
        color: AppColors.white,
      ),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );

    return SizedBox(
      height: 68,
      child: Pinput(
        length: length,
        controller: widget.controller,
        focusNode: focusNode,
        defaultPinTheme: defaultPinTheme,
        onCompleted: (pin) {
          setState(() => showError = pin != '5555');
        },
        focusedPinTheme: defaultPinTheme.copyWith(
          height: 43,
          width: 43,
          decoration: defaultPinTheme.decoration!.copyWith(
            border: Border.all(color: borderColor),
          ),
        ),
        errorPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            color: errorColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
