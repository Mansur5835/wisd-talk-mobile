import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:withtalk_mobile/core/utils/assets_manager.dart';

import '../../data/local_sources/local_storage.dart';

class LoadingViewWidget extends StatelessWidget {
  final double? radius;
  final int? duration;
  final bool isDark;

  const LoadingViewWidget(
      {Key? key, this.radius, this.isDark = false, this.duration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (radius ?? 0) * 2,
      height: (radius ?? 0) * 2,
      child: Lottie.asset(
          AssetsManager.lottie(
              name: (LocalStorage().readData(BoxKeys.APP_MODE) ?? false)
                  ? "loading_light"
                  : "loading_dark"),
          fit: BoxFit.cover),
    );
  }
}
