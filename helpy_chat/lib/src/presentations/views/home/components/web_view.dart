import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;
  bool isLoading = true; // Track loading state

  @override
  void initState() {
    final url = Get.parameters['url'] ??
        'https://develop.d2lu3r3hyjj34j.amplifyapp.com/';
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (navigation) {
            if (navigation.url != url) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onPageStarted: (url) {
            setState(() {
              isLoading = true; // Show loading indicator
            });
          },
          onPageFinished: (url) {
            setState(() {
              isLoading = false; // Hide loading indicator
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: WebViewWidget(
              controller: controller,
            ),
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
