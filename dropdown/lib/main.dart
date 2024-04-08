import 'package:flutter/material.dart';
import 'package:ll_dropdown_menu/ll_dropdown_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<DropDownItem> days = [];
  List<DropDownItem> months = [
    DropDownItem(
      text: "January",
      data: 0,
    ),
    DropDownItem(
      text: "February",
      data: 1,
    ),
    DropDownItem(
      text: "March",
      data: 2,
    ),
  ];

  final DropDownController dayController = DropDownController();
  final DropDownController monthController = DropDownController();
  final DropDownDisposeController dropDownDisposeController = DropDownDisposeController();


  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () {
      setupData();
      setState(() {});
    });
  }

  void setupData() {
    days = List.generate(30, (index) => DropDownItem(
        text: "${index + 1}",
        data: index,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DropDown"),
        backgroundColor: Colors.white,
      ),
      body: Column(children: [
        DropDownMenu(
          controller: dayController,
          disposeController: dropDownDisposeController,
          headerItemStyle: const DropDownItemStyle(
            activeIconColor: Colors.blue,
            activeTextStyle: TextStyle(color: Colors.blue),
          ),
          headerItems: [
            DropDownItem<Tab>(
              text: "pick day",
              icon: const Icon(Icons.arrow_drop_down),
              activeIcon: const Icon(Icons.arrow_drop_up),
            )
          ],
          viewOffsetY: MediaQuery.of(context).padding.top + 56,
          viewBuilders: [
            DropDownGridView(
              controller: dayController,
              crossAxisCount: 7,
              boxStyle: const DropDownBoxStyle(
                padding: EdgeInsets.all(16),
              ),
              itemStyle: DropDownItemStyle(
                activeBackgroundColor: const Color(0xFFF5F5F5),
                activeIconColor: Colors.blue,
                activeTextStyle: const TextStyle(color: Colors.blue),
                activeBorderRadius: BorderRadius.circular(6),
              ),
              items: days,
              headerIndex: 2,
              onDropDownHeaderUpdate: (List<DropDownItem> checkedItems) {
                return DropDownHeaderStatus(
                  text: checkedItems.map((e) => e.text).toList().join("、"),
                  highlight: checkedItems.isNotEmpty,
                );
              },
            ),
          ],
        ),
        DropDownMenu(
          controller: monthController,
          disposeController: dropDownDisposeController,
          headerItemStyle: const DropDownItemStyle(
            activeIconColor: Colors.blue,
            activeTextStyle: TextStyle(color: Colors.blue),
          ),
          headerItems: [
            DropDownItem<Tab>(
              text: "pick month",
              icon: const Icon(Icons.arrow_drop_down),
              activeIcon: const Icon(Icons.arrow_drop_up),
            )
          ],
          viewOffsetY: MediaQuery.of(context).padding.top + 115,
          viewBuilders: [
            DropDownGridView(
              controller: monthController,
              crossAxisCount: 3,
              boxStyle: const DropDownBoxStyle(
                padding: EdgeInsets.all(16),
              ),
              itemStyle: DropDownItemStyle(
                activeBackgroundColor: const Color(0xFFF5F5F5),
                activeIconColor: Colors.blue,
                activeTextStyle: const TextStyle(color: Colors.blue),
                activeBorderRadius: BorderRadius.circular(6),
              ),
              items: months,
              headerIndex: 2,
              onDropDownHeaderUpdate: (List<DropDownItem> checkedItems) {
                return DropDownHeaderStatus(
                  text: checkedItems.map((e) => e.text).toList().join("、"),
                  highlight: checkedItems.isNotEmpty,
                );
              },
            ),
          ],
        ),
      ]),
    );
  }
}
