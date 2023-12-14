import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Stadium Table Demo Page'),
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
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        child: Theme(
          data: Theme.of(context).copyWith(
            cardColor: Colors.transparent,
            dividerColor: Colors.transparent,
            cardTheme: CardTheme(
              color: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0, // remove shadow
              margin: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                  maxHeight: MediaQuery.of(context).size.height,
                ),
                child: DataTable2(
                    horizontalScrollController: ScrollController(),
                    headingRowColor:
                        MaterialStateColor.resolveWith((states) => Colors.blue),
                    columnSpacing: 12,
                    horizontalMargin: 12,
                    headingRowDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                    ),
                    // border: TableBorder.all(
                    //   borderRadius: BorderRadius.circular(22),
                    //   color: Colors.transparent,
                    // ),
                    columns: const [
                      DataColumn2(
                        label: Text('Column A'),
                        size: ColumnSize.L,
                      ),
                      DataColumn(
                        label: Text('Column B'),
                      ),
                      DataColumn(
                        label: Text('Column C'),
                      ),
                      DataColumn(
                        label: Text('Column D'),
                      ),
                      DataColumn(
                        label: Text('Column E'),
                        numeric: true,
                      ),
                      DataColumn(
                        label: Text('Column F'),
                        numeric: true,
                      ),
                      DataColumn(
                        label: Text('Column G'),
                        numeric: true,
                      ),
                      DataColumn(
                        label: Text('Column H'),
                        numeric: true,
                      ),
                      DataColumn(
                        label: Text('Column I'),
                        numeric: true,
                      ),
                    ],
                    rows: List<DataRow>.generate(
                        100,
                        (index) => DataRow(cells: [
                              DataCell(Text('A' * (10 - index % 10))),
                              DataCell(Text('B' * (10 - (index + 5) % 10))),
                              DataCell(Text('C' * (15 - (index + 5) % 10))),
                              DataCell(Text('D' * (15 - (index + 10) % 10))),
                              DataCell(Text('E' * (10 - (index + 5) % 10))),
                              DataCell(Text('F' * (15 - (index + 5) % 10))),
                              DataCell(Text('G' * (15 - (index + 10) % 10))),
                              DataCell(Text('H' * (15 - (index + 10) % 10))),
                              DataCell(Text(((index + 0.1) * 25.4).toString()))
                            ]))),
              ),
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
