import 'package:flutter/material.dart';
import 'package:naviscope/layouts/earth.dart';
import 'package:naviscope/layouts/mars.dart';
import 'package:naviscope/layouts/uranus.dart';
import 'package:naviscope/template/main_template.dart';

class SinglePage extends StatefulWidget {
  const SinglePage({super.key});

  @override
  State<SinglePage> createState() => _SinglePageState();
}

class _SinglePageState extends State<SinglePage> {

  int currentPosition = 0;
  List<Widget> planets = const [
    EarthLayout(),
    MarsLayout(),
    UranusLayout()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: MainTemplate(
          onMenuChoose: (position) => setState(() {
              currentPosition = position;
            }),
            child: planets[currentPosition],
          ),
        onWillPop: (){
          if(currentPosition == 0){
            return Future.value(true);
          }else{
            setState(() {
              currentPosition = 0;
            });
            return Future.value(false);
          }
        });
  }
}
