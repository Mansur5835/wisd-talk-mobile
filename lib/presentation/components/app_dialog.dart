import 'package:flutter/material.dart';

import '../../main.dart';

class AppDialog {
  final Widget? child;
  const AppDialog({this.child});

  Future show() async {
    showDialog(
        barrierDismissible: false,
        context: navigatorKey.currentContext!,
        builder: (context) => Scaffold(
            backgroundColor: Colors.transparent, body: child ?? Container()));
  }
}
