import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import '../../main.dart';
import '../styles/app_colors.dart';
import 'app_text.dart';

class AppToast {
  Future succesToast(String massage) async {
    MotionToast(
      icon: Icons.check_circle,
      animationCurve: Curves.linearToEaseOut,
      dismissable: false,
      // title: AppText("Top Motion Toast"),
      description: AppText(massage),
      position: MotionToastPosition.top,
      animationType: AnimationType.fromTop,
      primaryColor: AppColors.white,
      width: double.infinity,
      height: 80,
      // iconSize: 0,
      padding: EdgeInsets.zero,
      secondaryColor: Colors.green,
    ).show(navigatorKey.currentContext!);
  }

  void errorToast(String massage, {Duration? duration, Color? barrierColor}) {
    MotionToast(
      icon: Icons.error,
      animationCurve: Curves.linearToEaseOut,
      dismissable: false,
      // title: AppText("Top Motion Toast"),
      description: AppText(
        massage,
        color: AppColors.primaryBlack,
        fontWeight: FontWeight.w600,
      ),
      position: MotionToastPosition.top,
      animationType: AnimationType.fromTop,
      primaryColor: AppColors.red,
      width: double.infinity,
      height: 80,
      // iconSize: 0,
      toastDuration: duration ?? const Duration(seconds: 3),
      padding: EdgeInsets.zero,
      barrierColor: barrierColor ?? Colors.transparent,
    ).show(navigatorKey.currentContext!);
  }
}
