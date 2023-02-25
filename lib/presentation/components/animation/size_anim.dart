import 'package:flutter/material.dart';

import '../../../core/utils/screen_size.dart';

class SizeAnim extends StatelessWidget {
  final int? duration;
  final Widget child;
  final double? width;

  const SizeAnim({super.key, this.duration, required this.child, this.width});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 10, end: width ?? ScreenSize.size().width),
      duration: Duration(milliseconds: duration ?? 1200),
      builder: (con, value, _) {
        return SizedBox(width: value, child: child);
      },
    );
  }
}
