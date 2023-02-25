import 'package:flutter/material.dart';
import 'package:withtalk_mobile/presentation/components/loading_view_widget.dart';

import '../../core/utils/dio_utils.dart';
import '../../main.dart';
import '../../repository/rest_client.dart';
import '../routes/app_navigator.dart';

final client = RestClient(dio);
final loading = LoadingController();

class LoadingController {
  bool isLoading = false;
  Future<void> showLoading() async {
    isLoading = true;
    await showDialog(
        context: navigatorKey.currentContext!,
        builder: (c) {
          return AlertDialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: Container(
              alignment: Alignment.center,
              child: const LoadingViewWidget(
                radius: 50,
                isDark: true,
              ),
            ),
          );
        }).then((value) {
      isLoading = false;
    });
  }

  Future<void> hideLoading() async {
    AppNavigator.back();
  }
}
