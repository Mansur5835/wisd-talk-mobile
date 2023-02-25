import 'package:flutter/material.dart';
import 'package:withtalk_mobile/main.dart';
import 'package:withtalk_mobile/presentation/components/views/has_not_user_action_view,.dart';
import '../../core/utils/assets_manager.dart';
import '../styles/app_colors.dart';
import 'app_dialog.dart';

// ignore: must_be_immutable
class AppLikeButton extends StatefulWidget {
  final Future<void> Function(bool)? onTab;
  final bool withBackground;
  final Color? color;
  final double? size;
  bool isFavorit;

  AppLikeButton(
      {super.key,
      this.color,
      this.isFavorit = false,
      this.size,
      this.withBackground = false,
      this.onTab});

  @override
  State<AppLikeButton> createState() => _AppLikeButtonState();
}

class _AppLikeButtonState extends State<AppLikeButton>
    with TickerProviderStateMixin {
  bool isFavorit = false;
  late final Animation<double> _animation;
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    isFavorit = widget.isFavorit;

    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 700),
        reverseDuration: const Duration(milliseconds: 700));

    _animation =
        Tween<double>(begin: widget.size ?? 20, end: (widget.size ?? 20) + 10)
            .animate(CurvedAnimation(
                parent: _animationController, curve: Curves.bounceIn));
    setState(() {});
  }

  void animateTab() async {
    _animationController.forward();
    await Future.delayed(const Duration(milliseconds: 1000));
    await widget.onTab!(!isFavorit);
    setState(() {
      isFavorit = !isFavorit;
    });
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!hasUser) {
          const AppDialog(
            child: HasNotUserAvtionView(),
          ).show();
          return;
        }
        animateTab();
      },
      child: !widget.withBackground
          ? AnimatedBuilder(
              animation: _animation,
              builder: (context, _) {
                return Image.asset(
                  AssetsManager.icon(
                    name: "love",
                  ),
                  width: _animation.value,
                  height: _animation.value,
                  fit: BoxFit.cover,
                  color: isFavorit
                      ? AppColors.red
                      : widget.color ?? AppColors.primaryBlack,
                );
              })
          : CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.primaryBlack05,
              child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, _) {
                    return Image.asset(
                      AssetsManager.icon(
                        name: "love",
                      ),
                      width: _animation.value,
                      height: _animation.value,
                      fit: BoxFit.cover,
                      color: isFavorit ? AppColors.red : AppColors.white,
                    );
                  }),
            ),
    );
  }
}
