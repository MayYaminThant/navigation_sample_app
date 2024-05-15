import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  ByteData? fontData;
  // late Uint8List fontData;
  pw.Font? pyidaungsu;

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   fontData = await rootBundle.load("font/PyidaungsuRegular.ttf");
    //   setState(() {});
    // });
    Future.delayed(Duration.zero, () => loadFont());
    super.initState();
  }

  loadFont() async {
    fontData = await rootBundle.load("assets/font/Pyidaungsu2.ttf");
    pyidaungsu = await fontFromAssetBundle('assets/font/Pyidaungsu2.ttf');
    // pyidaungsu = pw.Font.ttf(fontData!);
    // fontData = File('assets/font/PyidaungsuRegular.ttf').readAsBytesSync();
    // pyidaungsu = pw.Font.ttf(fontData.buffer.asByteData());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PdfPreview(
        initialPageFormat: PdfPageFormat.roll80,
        allowSharing: false,
        allowPrinting: false,
        canChangeOrientation: false,
        canChangePageFormat: false,
        maxPageWidth: PdfPageFormat.roll80.width * 2.2,
        build: (format) => _generatePdf(),
      ),
    );
  }

  Future<Uint8List> _generatePdf() async {
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll80,
        margin: const pw.EdgeInsets.all(8),
        build: (pw.Context bContext) {
          return pw.Container(
              width: PdfPageFormat.roll80.width,
              padding: const pw.EdgeInsets.only(
                right: 4,
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  pw.SizedBox(height: 4),
                  pw.Text(
                    'SSS International Co.,ltd',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      color: PdfColor.fromHex("#000000"),
                      fontSize: 7,
                    ),
                  ),
                  pw.Text(
                    'contact@sssretail.com',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      color: PdfColor.fromHex("#000000"),
                      fontSize: 7,
                    ),
                  ),
                  pw.Text(
                    '''https://www.sssretail.com
                    ထွန်းအောင်လင်း
                    ထွန်းေအာင်လင်း''',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      color: PdfColor.fromHex("#000000"),
                      fontSize: 7,
                      font: pyidaungsu
                    ),
                  ),
                  pw.SizedBox(height: 30),
                  ..._thankYouWidget(),
                ],
              ));
        },
      ),
    );

    return doc.save();
  }

  List<pw.Widget> _thankYouWidget() {
    return [
      pw.Container(
        width: PdfPageFormat.roll80.width,
        padding: const pw.EdgeInsets.only(right: 8),
        child: pw.Text(
          '၀ယ်ပြီးပစ္စည်း ပြန်မလဲပေးပါ။', //unicode
          textAlign: pw.TextAlign.center,
          style: pw.TextStyle(
            color: PdfColor.fromHex("#262927"),
            fontSize: 8.8,
            font: pyidaungsu,
            fontFallback: [
              pyidaungsu!
            ]
            // font: fontData != null ? pw.Font.ttf(fontData!) : null,
          ),
        ),
      ),
      pw.SizedBox(height: 20),
      pw.Container(
        width: PdfPageFormat.roll80.width,
        padding: const pw.EdgeInsets.only(right: 8),
        child: pw.Text(
          'ဝယ်ြပီးပစ္စည်း ြပန်မလဲေပးပါ',
          // '၀ယ္ၿပီးပစၥည္း ျပန္မလဲေပးပါ။', //zawgyi
          textAlign: pw.TextAlign.center,
          style: pw.TextStyle(
            color: PdfColor.fromHex("#262927"),
            fontSize: 8.8,
            font: pyidaungsu
            // font: fontData != null ? pw.Font.ttf(fontData!) : null,
          ),
        ),
      ),
    ];
  }
}
