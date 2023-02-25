import 'package:flutter/material.dart';
import '../../main.dart';
import '../styles/app_colors.dart';
import '../styles/app_theme.dart';
import 'app_text.dart';

class AppBottomSheet<T> {
  final double? height;

  final Function? onClose;
  String? title;
  final String? subTitle;
  bool withTitle;

  Widget child;

  AppBottomSheet(
      {Key? key,
      required this.child,
      this.subTitle,
      this.height,
      this.onClose,
      this.title,
      this.withTitle = true});

  Widget _sheet() {
    return StatefulBuilder(builder: (context, setState) {
      return BottomSheet(onClosing: () {
        onClose?.call();
      }, builder: ((context) {
        return Container(
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(navigatorKey.currentContext!)
                  .viewInsets
                  .bottom),
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
              color:
                  withTitle ? AppTheme.backColor(context) : Colors.transparent,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    AppText(
                      title,
                      fontWeight: FontWeight.bold,
                      size: 18,
                      color: AppTheme.oppositePrimaryColor(context),
                    ),
                    if (subTitle != null)
                      AppText(
                        subTitle,
                        fontWeight: FontWeight.bold,
                        size: 16,
                        color: AppColors.grey,
                      ),
                  ],
                ),
              ),
              Expanded(child: child),
            ],
          ),
        );
      }));
    });
  }

  Future<dynamic> show() async {
    var result = await showModalBottomSheet(
        isScrollControlled: true,
        context: navigatorKey.currentContext!,
        builder: (c) {
          return _sheet();
        });

    return result;
  }
}
