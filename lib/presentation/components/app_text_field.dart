import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/assets_manager.dart';
import '../styles/app_colors.dart';
import '../styles/app_theme.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final IconData? icon;
  Function(String)? onChanged;
  Function(String)? onSubmitted;
  bool iconColorChangingCondition;
  final double? radius;
  final FormFieldValidator<String>? validator;
  final TextInputFormatter? mask;
  final TextInputType? textInputType;
  final Function()? iconTab;
  final bool autofocus;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final EdgeInsets? margin;
  final Color? color;
  final bool withFontWeight;
  final bool withPass;
  final Widget? prefixIcon;
  final TextCapitalization? textCapitalization;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  AppTextField(
      {Key? key,
      this.controller,
      this.prefixIcon,
      this.color,
      this.radius,
      this.withFontWeight = false,
      this.autofocus = false,
      this.onSubmitted,
      this.textCapitalization,
      required this.label,
      this.margin,
      this.suffixIcon,
      this.onChanged,
      this.textInputAction,
      this.iconTab,
      this.textInputType,
      this.validator,
      this.mask,
      this.withPass = false,
      this.inputFormatters,
      this.maxLines,
      this.icon,
      this.iconColorChangingCondition = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.all(20),
      alignment: Alignment.centerLeft,
      child: TextFormField(
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        maxLines: maxLines,
        autofocus: autofocus,
        validator: validator,
        style: GoogleFonts.openSans(
            color: AppTheme.oppositePrimaryColor(context),
            fontWeight: withFontWeight ? FontWeight.w600 : FontWeight.normal),
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        textInputAction: textInputAction,
        inputFormatters: inputFormatters,
        obscureText: withPass,
        keyboardType: textInputType,
        controller: controller,
        cursorColor: AppTheme.oppositePrimaryColor(context),
        decoration: InputDecoration(
          // ignore: prefer_if_null_operators
          prefixIcon: prefixIcon == null ? null : prefixIcon,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 15),
              borderSide: BorderSide(color: AppColors.primaryBlack, width: 1)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 15),
              borderSide: BorderSide(color: AppColors.red, width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 15),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: color,
          suffixIcon: GestureDetector(
            onTap: () {
              iconTab!();
            },
            child: Icon(
              icon,
              color: iconColorChangingCondition
                  ? AppTheme.primaryColor(context)
                  : AppTheme.oppositePrimaryColor(context),
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          hintText: label,
          errorStyle: TextStyle(color: AppColors.red),
          hintStyle: TextStyle(color: AppTheme.grey1(context)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 15),
              borderSide: BorderSide(
                  color: AppTheme.oppositePrimaryColor(context), width: 1)),
        ),
      ),
    );
  }
}
