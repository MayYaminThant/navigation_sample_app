import 'package:flutter/material.dart';
import 'package:naviscope/history_page/history_page.dart';
import 'package:naviscope/single_page/single_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Navigation Pages'),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.looks_one_rounded),
              title: const Text("one page"),
              subtitle: const Text("press back button to go back home layout"),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SinglePage()),
                ),
            ),
            ListTile(
              leading: const Icon(Icons.repeat_on),
              title: const Text("history page"),
              subtitle: const Text("press back button to go back history"),
              onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HistoryPage()),
              ),
            ),
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
