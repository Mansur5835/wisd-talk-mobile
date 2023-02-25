import 'package:flutter/material.dart';
import 'package:withtalk_mobile/presentation/components/app_text.dart';
import 'package:withtalk_mobile/presentation/styles/app_colors.dart';
import 'package:withtalk_mobile/presentation/styles/app_theme.dart';

class AppSelectItem extends StatefulWidget {
  AppSelectItem(
      {super.key,
      required this.onTap,
      required this.title,
      this.isSelecded = false,
      this.withBorder = true});
  final String title;
  bool isSelecded;
  Function() onTap;
  bool withBorder;

  @override
  State<AppSelectItem> createState() => _AppSelectItemState();
}

class _AppSelectItemState extends State<AppSelectItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.only(right: 10),
        alignment: Alignment.center,
        height: 40,
        decoration: BoxDecoration(
            border: widget.isSelecded
                ? widget.withBorder
                    ? Border.all(width: 2, color: AppColors.primaryColor1)
                    : null
                : null,
            color: widget.isSelecded
                ? AppColors.primaryColor
                : AppTheme.primaryColor(context),
            borderRadius: BorderRadius.circular(10)),
        child: AppText(
          widget.title,
          color: widget.isSelecded
              ? AppColors.white
              : AppTheme.oppositePrimaryColor(context),
        ),
      ),
    );
  }
}
