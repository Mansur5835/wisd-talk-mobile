import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppZoomImage extends StatefulWidget {
  Widget child;

  AppZoomImage({Key? key, required this.child}) : super(key: key);

  @override
  State<AppZoomImage> createState() => _ZoomImageState();
}

class _ZoomImageState extends State<AppZoomImage>
    with SingleTickerProviderStateMixin {
  late TransformationController controller;
  late AnimationController animationController;
  Animation<Matrix4>? animation;

  @override
  void initState() {
    controller = TransformationController();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200))
          ..addListener(() {
            controller.value = animation!.value;
          });
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
        clipBehavior: Clip.none,
        transformationController: controller,
        minScale: 1,
        maxScale: 5,
        onInteractionEnd: (details) {
          print("asfasdf");
          _resetAnimatioon();
        },
        child: widget.child);
  }

  _resetAnimatioon() {
    animation = Matrix4Tween(
      begin: controller.value,
      end: Matrix4.identity(),
    ).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    animationController.forward(from: 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
    animationController.dispose();
  }
}
