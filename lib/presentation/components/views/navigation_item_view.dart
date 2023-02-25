import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/assets_manager.dart';
import '../../styles/app_colors.dart';
import '../../styles/app_theme.dart';
import '../app_text.dart';

class NavigationItemView extends StatefulWidget {
  final String? icon;
  final String? activeIcon;
  final String? label;
  final Function? onTab;

  bool selected;
  bool withBadge;
  int badgeCount;
  NavigationItemView(
      {super.key,
      this.onTab,
      this.activeIcon,
      this.withBadge = false,
      this.icon,
      this.badgeCount = 0,
      this.label,
      this.selected = false});

  @override
  State<NavigationItemView> createState() => _NavigationItemViewState();
}

class _NavigationItemViewState extends State<NavigationItemView>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _animationOffset;
  late final Animation<double> _animationSize;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 100),
        reverseDuration: const Duration(milliseconds: 100));

    _animationOffset = Tween(begin: Offset.zero, end: const Offset(0, -0.1))
        .animate(
            CurvedAnimation(parent: _controller, curve: Curves.bounceInOut));

    _animationSize = Tween<double>(begin: 25, end: 30).animate(
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
  }

  _animateIcon() async {
    _controller.forward();
    await Future.delayed(const Duration(milliseconds: 100));
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () async {
            await _animateIcon();
            widget.onTab!();
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Badge(
                borderSide: BorderSide(color: AppColors.white, width: 2),
                badgeColor: AppColors.primaryColor,
                animationDuration: Duration(milliseconds: 2000),
                elevation: 0,
                padding: const EdgeInsets.all(6),
                showBadge: widget.withBadge,
                position: const BadgePosition(top: -3, end: -12),
                animationType: BadgeAnimationType.slide,
                badgeContent: AppText(
                  "+${widget.badgeCount}",
                  size: 10,
                  color: AppColors.white,
                ),
                child: SlideTransition(
                  position: _animationOffset,
                  child: AnimatedBuilder(
                    animation: _animationSize,
                    builder: (context, child) {
                      return Image.asset(
                        AssetsManager.icon(
                            name: widget.selected
                                ? widget.activeIcon ?? ""
                                : widget.icon ?? ""),
                        width: _animationSize.value,
                        height: _animationSize.value,
                        fit: BoxFit.cover,
                        color: widget.selected
                            ? AppColors.primaryColor
                            : AppTheme.grey1(context),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              AppText(
                widget.label,
                size: 10,
                color: widget.selected
                    ? AppTheme.oppositePrimaryColor(context)
                    : AppTheme.grey1(context),
                fontWeight:
                    widget.selected ? FontWeight.bold : FontWeight.normal,
              )
            ],
          ),
        ),
      ),
    );
  }
}
