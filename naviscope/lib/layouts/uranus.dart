import 'package:flutter/material.dart';
import 'package:naviscope/constants/style_constants.dart';

class UranusLayout extends StatefulWidget {
  const UranusLayout({super.key});

  @override
  State<UranusLayout> createState() => _UranusLayoutState();
}

class _UranusLayoutState extends State<UranusLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent.withAlpha(50),
      child: const Center(
        child: Text('U R A N U S', style: NaviStyle.uranusStyle,),
      ),
    );
  }
}
