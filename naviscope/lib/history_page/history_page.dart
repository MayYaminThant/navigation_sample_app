import 'package:flutter/material.dart';
import 'package:naviscope/layouts/earth.dart';
import 'package:naviscope/layouts/mars.dart';
import 'package:naviscope/layouts/uranus.dart';
import 'package:naviscope/template/main_template.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  List<int> history = [0];
  List<Widget> planets = const [
    EarthLayout(),
    MarsLayout(),
    UranusLayout()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: MainTemplate(
          onMenuChoose: (position) => setState(() => history.add(position)),
          child: planets[history.last],
        ),
        onWillPop: (){
          if(history.length < 2){
            return Future.value(true);
          }else{
            setState(() => history.removeLast());
            return Future.value(false);
          }
        });
  }
}
