import 'package:flutter/material.dart';
import 'package:naviscope/constants/style_constants.dart';

class MarsLayout extends StatefulWidget {
  const MarsLayout({super.key});

  @override
  State<MarsLayout> createState() => _MarsLayoutState();
}

class _MarsLayoutState extends State<MarsLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent.withAlpha(50),
      child: const Center(
        child: Text('M A R S', style: NaviStyle.marsStyle,),
      ),
    );
  }
}
