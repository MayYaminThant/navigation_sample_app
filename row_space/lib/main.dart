import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: _bodyWidget());
  }

  Widget _bodyWidget() {
    return Container(
      constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height / 2,
          minWidth: (MediaQuery.of(context).size.width / 2) -
              MediaQuery.of(context).size.width / 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 30, vertical: 10),
      padding: const EdgeInsets.all(20),
      child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Product Computation',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ..._infoWidget(),
                  ],
                ),
              ),
            ),
            // todo: (problem)second widget is not place at center
            Expanded(
              flex: 1,
              child: Text(
                'The computed price is expressed in the default Unit of Measure of the product.',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ]),
    );
  }

  List<Widget> _infoWidget() {
    var spacer = const SizedBox(height: 15);

    return [
      spacer,
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _textForDetailInfo("Computation")),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                _eachRadioWidget(
                  text: 'Fixed Price',
                  value: 0,
                  selected: true,
                  groupValue: 0,
                ),
                _eachRadioWidget(
                  text: 'Discount',
                  value: 1,
                  selected: false,
                  groupValue: 0,
                ),
                _eachRadioWidget(
                  text: 'Formula',
                  value: 2,
                  selected: false,
                  groupValue: 0,
                ),
              ],
            ),
          ),
        ],
      ),
      spacer,
      Row(
        children: [
          Expanded(child: _textForDetailInfo("Fixed Price")),
          Expanded(flex: 2, child: _textForDetailInfo('1300.00 Ks')),
        ],
      ),
      spacer,
      _textForDetailInfo("Conditions"),
      spacer,
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _textForDetailInfo("Apply On")),
          Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _eachRadioWidget(
                        text: 'All Product',
                        value: 0,
                        selected: true,
                        groupValue: 1,
                      ),
                      _eachRadioWidget(
                        text: 'Product Category',
                        value: 1,
                        selected: false,
                        groupValue: 1,
                      ),
                      _eachRadioWidget(
                        text: 'Product',
                        value: 2,
                        selected: false,
                        groupValue: 1,
                      ),
                      _eachRadioWidget(
                        text: 'Product Varient',
                        value: 3,
                        selected: false,
                        groupValue: 1,
                      ),
                      _eachRadioWidget(
                        text: 'Product Package',
                        value: 4,
                        selected: false,
                        groupValue: 1,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: _textForDetailInfo("Quantity")),
                          Expanded(
                              flex: 2, child: _textForDetailInfo('1000.00')),
                        ],
                      ),
                      spacer,
                      Row(
                        children: [
                          Expanded(child: _textForDetailInfo("Validity")),
                          Expanded(
                              flex: 2,
                              child: _textForDetailInfo('12.07.2024 12:00:00')),
                        ],
                      ),
                      spacer,
                      Row(
                        children: [
                          Expanded(child: _textForDetailInfo("Currency")),
                          Expanded(flex: 2, child: _textForDetailInfo('MMK')),
                        ],
                      ),
                      spacer,
                      Row(
                        children: [
                          Expanded(child: _textForDetailInfo("Company")),
                          Expanded(
                              flex: 2,
                              child: _textForDetailInfo(
                                  'SSS International Co;Ltd')),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ];
  }

  RadioListTile<int> _eachRadioWidget({
    required int value,
    required bool selected,
    required int groupValue,
    required String text,
  }) {
    return RadioListTile(
      value: value,
      selected: selected,
      activeColor: Colors.blue,
      fillColor: MaterialStateColor.resolveWith((states) => Colors.blue),
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
      groupValue: groupValue,
      onChanged: (Object? value) {},
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _textForDetailInfo(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 17,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
