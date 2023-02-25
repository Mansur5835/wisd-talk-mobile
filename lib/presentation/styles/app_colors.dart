import 'package:flutter/material.dart';

import '../../core/extansions/hex_color.dart';

abstract class AppColors {
  static final Color primaryColor = HexColor("#767fcb");
  static final Color primaryColor07 = HexColor("#767fcb").withOpacity(0.7);
  static final Color primaryColor01 = HexColor("#767fcb").withOpacity(0.1);
  static final Color primaryColor1 = HexColor("#dcc2fc");

  static final Color primaryBlack = HexColor("#05050C");
  static final Color primaryBlack03 = HexColor("#2b2935").withOpacity(0.3);
  static final Color primaryBlack05 = HexColor("#2b2935").withOpacity(0.5);

  static final Color primaryBlack1 = HexColor("#777787");
  static final Color primaryBlack2 = HexColor("#35383F");
  static final Color blackGrey = HexColor("#35383F");
  static final Color blackGrey1 = HexColor("#9C9E9F");

  static final Color blue = HexColor("#259ADB");
  static final Color green = HexColor("#00D394");
  static final Color red = HexColor("#FF3939");
  static final Color red05 = HexColor("#FF3939").withOpacity(0.8);

  static final Color white = HexColor("#ffffff");

  static final Color grey = HexColor("#B4B4B8");
  static final Color grey1 = HexColor("#e7e7e7");

  static final Color backLight = HexColor("#F9F9FC");
  static final Color backDark = HexColor("#2b2935");
  static final Color detailButtunColor = HexColor("#F1F3FA");
}
