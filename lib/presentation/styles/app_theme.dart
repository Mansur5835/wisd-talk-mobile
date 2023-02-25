import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData light() {
    return ThemeData(
      primaryColor: AppColors.white,
      disabledColor: AppColors.primaryBlack,
      accentColor: AppColors.grey,
      canvasColor: AppColors.primaryBlack05,
      cardColor: AppColors.grey1,
      hintColor: AppColors.primaryBlack05,
      errorColor: AppColors.primaryBlack,
      bottomAppBarColor: AppColors.white,
      focusColor: AppColors.grey1,
      hoverColor: AppColors.backLight,
      bottomSheetTheme:
          BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      primaryColor: AppColors.primaryBlack,
      disabledColor: AppColors.white,
      accentColor: AppColors.blackGrey,
      canvasColor: AppColors.blackGrey1,
      cardColor: AppColors.blackGrey,
      hintColor: AppColors.blackGrey1,
      errorColor: AppColors.primaryBlack2,
      bottomAppBarColor: AppColors.primaryBlack2,
      focusColor: AppColors.primaryBlack03,
      hoverColor: AppColors.backDark,
      bottomSheetTheme:
          BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
    );
  }

  static Color primaryColor(BuildContext context) {
    return Theme.of(context).primaryColor;
  }

  static Color oppositePrimaryColor(BuildContext context) {
    return Theme.of(context).disabledColor;
  }

  static Color grey(BuildContext context) {
    return Theme.of(context).accentColor;
  }

  static Color grey1(BuildContext context) {
    return Theme.of(context).hintColor;
  }

  static Color backColor(BuildContext context) {
    return Theme.of(context).hoverColor;
  }

  static Color textColor(BuildContext context) {
    return Theme.of(context).canvasColor;
  }

  static Color avatarColor(BuildContext context) {
    return Theme.of(context).cardColor;
  }

  static bottomSheetColor(BuildContext context) {}
}
