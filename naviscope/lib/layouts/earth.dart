import 'package:flutter/material.dart';
import 'package:naviscope/constants/style_constants.dart';

class EarthLayout extends StatefulWidget {
  const EarthLayout({super.key});

  @override
  State<EarthLayout> createState() => _EarthLayoutState();
}

class _EarthLayoutState extends State<EarthLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.withAlpha(50),
      child: const Center(
        child: Text('E A R T H', style: NaviStyle.earthStyle,),
      ),
    );
  }
}
