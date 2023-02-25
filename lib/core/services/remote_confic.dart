import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../main.dart';
import '../../presentation/routes/app_navigator.dart';

class CheckAppVersionService {
  static CheckAppVersionService instance = CheckAppVersionService._();

  CheckAppVersionService._() {}

  final firebaseFirestore =
      FirebaseFirestore.instance.collection('wisdtalk-mobile');

  Future<void> init() async {
    var appVersionDoc = await firebaseFirestore.doc("app-version").get();
    var appVersion = appVersionDoc.data();

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String currentVersion = packageInfo.version;

    String newVersion = '';

    if (Platform.isAndroid) {
      newVersion = appVersion?["android_version"] ?? "1.0.0";
    } else {
      newVersion = appVersion?["ios_version"] ?? "1.0.0";
    }

    _checkAppVersion(currentVersion, newVersion);
  }

  _checkAppVersion(String oldVersion, String newVersion) async {
    int oldVersionInt = versionStringToInt(oldVersion);
    int newVersionInt = versionStringToInt(newVersion);

    if (oldVersionInt < newVersionInt) {
      await Future.delayed(const Duration(seconds: 5));
      _showCompulsoryUpdateDialog(navigatorKey.currentContext!,
          "У нас новая версия, пожалуйста, обновите приложение.\nВерсия у вас $oldVersion\nНовая версия $newVersion");
    }
  }

  int versionStringToInt(String version) {
    return (int.tryParse(version.replaceAll(".", "")) ?? 100);
  }

  _showCompulsoryUpdateDialog(context, String message) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "Обновление в приложении";
        String btnLabel = "Обновить сейчас";
        String btnCencal = "Отмена";
        return Platform.isIOS
            ? CupertinoAlertDialog(
                title: Text(title),
                content: Text(
                  message,
                ),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text(
                      btnCencal,
                    ),
                    isDefaultAction: true,
                    onPressed: () {
                      AppNavigator.back();
                    },
                  ),
                  CupertinoDialogAction(
                    child: Text(
                      btnLabel,
                    ),
                    isDefaultAction: true,
                    onPressed: () {
                      // launch("");

                      AppNavigator.back();
                    },
                  ),
                ],
              )
            : AlertDialog(
                title: Text(title),
                content: Text(message),
                actions: [
                  TextButton(
                      onPressed: () {
                        AppNavigator.back();
                      },
                      child: Text(btnCencal)),
                  TextButton(
                      onPressed: () {
                        // launch("");
                        AppNavigator.back();
                      },
                      child: Text(btnLabel))
                ],
              );
      },
    );
  }
}
