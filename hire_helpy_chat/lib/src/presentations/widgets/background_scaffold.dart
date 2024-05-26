import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dh_employer/src/presentations/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BackgroundScaffold extends StatefulWidget {
  const BackgroundScaffold({super.key, required this.scaffold, this.onWillPop});

  final Scaffold scaffold;
  final Function? onWillPop;

  @override
  State<BackgroundScaffold> createState() => _BackgroundScaffoldState();
}

class _BackgroundScaffoldState extends State<BackgroundScaffold> {
  ConnectivityResult _connectionStatus = ConnectivityResult.mobile;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException {
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        if (widget.onWillPop == null) return false;
        widget.onWillPop!();
        return false;
      },
      child: _connectionStatus == ConnectivityResult.none
          ? const NoInternetSection()
          : Container(
              width: width,
              height: height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.cover)),
              child: GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: widget.scaffold),
            ),
    );
  }
}
