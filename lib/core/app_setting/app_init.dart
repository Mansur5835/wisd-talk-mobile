import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../data/local_sources/local_storage.dart';
import '../utils/dio_interceptor.dart';
import '../utils/dio_utils.dart';

class AppInit {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    await Firebase.initializeApp();

    ///hive service
    await Hive.initFlutter();
    await Hive.openBox(LocalStorage.BOX_NAME);
    HttpOverrides.global = MyHttpOverrides();
    DioUtils.settingDio();
  }
}
