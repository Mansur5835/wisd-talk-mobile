import 'package:flutter/material.dart';
import 'package:withtalk_mobile/core/utils/assets_manager.dart';

import '../../styles/app_theme.dart';

class UserAvatar extends StatelessWidget {
  double size;
  UserAvatar({super.key, this.size = 90});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: AppTheme.avatarColor(context),
          borderRadius: BorderRadius.circular(123)),
      child: Image.asset(
        AssetsManager.icon(name: "profile"),
        width: size - 20,
        height: size - 20,
        color: AppTheme.grey1(context),
      ),
    );
  }
}
