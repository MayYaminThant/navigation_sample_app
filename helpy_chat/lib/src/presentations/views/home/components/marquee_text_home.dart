import 'package:dh_mobile/src/presentations/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MarqueeTextHome extends StatelessWidget {
  final String message;
  final String colorCode;
  final Color fontColor;
  final bool isShowIcon;
  const MarqueeTextHome(
      {super.key,
      required this.message,
      required this.colorCode,
      required this.isShowIcon,
      required this.fontColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 28,
      decoration: BoxDecoration(color: HexColor(colorCode)),
      child: Marquee(
        text: message,
        isShowIcon: isShowIcon,
        style: GoogleFonts.poppins(
            fontSize: 12, fontWeight: FontWeight.w600, color: fontColor),
        scrollAxis: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        blankSpace: 20.0,
        velocity: 50.0,
        pauseAfterRound: const Duration(seconds: 3),
        startPadding: 10.0,
        accelerationDuration: const Duration(seconds: 1),
        accelerationCurve: Curves.linear,
        decelerationDuration: const Duration(milliseconds: 500),
        decelerationCurve: Curves.easeOut,
      ),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }
}
