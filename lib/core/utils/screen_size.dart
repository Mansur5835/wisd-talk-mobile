import 'package:flutter/material.dart';

import '../../main.dart';

class ScreenSize {
  static Size size() {
    return MediaQuery.of(navigatorKey.currentContext!).size;
  }
}
