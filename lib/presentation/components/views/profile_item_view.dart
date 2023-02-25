import 'package:flutter/material.dart';

import '../../../core/utils/assets_manager.dart';
import '../../styles/app_theme.dart';
import '../app_text.dart';

class ProfileItemView extends StatelessWidget {
  final String? icon;
  final String? title;
  final String? subTitle;
  final Function()? onTab;
  final Color? color;
  final Widget? trailing;
  const ProfileItemView(
      {super.key,
      this.icon,
      this.color,
      this.trailing,
      this.subTitle,
      this.title,
      this.onTab});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        AssetsManager.icon(name: icon ?? ""),
        width: 30,
        height: 30,
        color: color ?? AppTheme.oppositePrimaryColor(context),
      ),
      title: AppText(
        title,
        size: 14,
        fontWeight: FontWeight.w500,
        color: color ?? AppTheme.oppositePrimaryColor(context),
      ),
      onTap: onTab,
      trailing: trailing ??
          Icon(
            Icons.chevron_right_rounded,
            color: AppTheme.oppositePrimaryColor(context),
          ),
    );
  }
}
