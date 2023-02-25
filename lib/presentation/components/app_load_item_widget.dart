import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:withtalk_mobile/core/utils/pagination_maker.dart';
import 'package:withtalk_mobile/presentation/cubits/app_theme_cubit.dart';
import '../../core/utils/assets_manager.dart';
import '../styles/app_theme.dart';
import 'app_text.dart';
import 'loading_view_widget.dart';

typedef CallbackFunc<bool> = Future<void> Function();

// ignore: must_be_immutable
class AppLoadItemView extends StatefulWidget {
  List<Widget> items;
  final ScrollController? parentScrollController;
  final CallbackFunc? loadMore;
  final bool isGrid;
  final String? notFountItemsText;

  AppLoadItemView(
      {super.key,
      this.parentScrollController,
      required this.items,
      this.isGrid = true,
      this.loadMore,
      this.notFountItemsText});

  @override
  State<AppLoadItemView> createState() => _AppLoadItemViewState();
}

class _AppLoadItemViewState extends State<AppLoadItemView> {
  bool isLoading = false;
  bool permissionToCall = true;

  @override
  void initState() {
    super.initState();

    widget.parentScrollController?.addListener(_listener);
  }

  _listener() {
    if (permissionToCall == false) {
      return;
    }
    // ignore: non_constant_identifier_names
    double? MAX_SCROLL_OFFSET =
        widget.parentScrollController?.position.maxScrollExtent;

    // ignore: non_constant_identifier_names
    double? CURRENT_SCROLL_OFFSET = widget.parentScrollController?.offset;

    if (MAX_SCROLL_OFFSET == null || CURRENT_SCROLL_OFFSET == null) {
      return;
    }

    if (((MAX_SCROLL_OFFSET - CURRENT_SCROLL_OFFSET).abs() < 100) && mounted) {
      permissionToCall = false;
      setState(() {
        isLoading = true;
        loadData();
      });
    }
  }

  loadData() async {
    await widget.loadMore!.call();

    setState(() {
      isLoading = false;
      Future.delayed(const Duration(milliseconds: 100), () {
        permissionToCall = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    int _index = -2;
    return widget.items.isEmpty
        ? Container(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 60,
                ),
                Lottie.asset(AssetsManager.lottie(name: "empty"),
                    width: 200, height: 200),
                AppText(
                  "not_found_products".tr(),
                  color: AppTheme.oppositePrimaryColor(context),
                  size: 18,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ))
        : Column(
            children: List.generate(logicLength(), (index) {
              if (!widget.isGrid) {
                return widget.items[index];
              }

              _index += 2;
              return Row(
                children: [
                  Expanded(
                    child: item(_index),
                  ),
                  Expanded(
                    child: item(_index + 1),
                  ),
                ],
              );
            })
              ..add(isLoading
                  ? BlocBuilder<AppThemeCubit, AppThemeState>(
                      builder: (context, state) {
                        return Container(
                          height: 80,
                          alignment: Alignment.center,
                          child: LoadingViewWidget(
                            radius: 40,
                            isDark: state.isDark,
                          ),
                        );
                      },
                    )
                  : Container()),
          );
  }

  item(int index) {
    if (index > (widget.items.length - 1)) {
      return Container();
    }

    return widget.items[index];
  }

  logicLength() {
    if (!widget.isGrid) {
      return widget.items.length;
    }
    if (widget.items.length.isOdd) {
      return (widget.items.length ~/ 2) + 1;
    }

    return widget.items.length ~/ 2;
  }
}
