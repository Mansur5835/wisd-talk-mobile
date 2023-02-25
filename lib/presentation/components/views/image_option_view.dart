import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:withtalk_mobile/core/utils/assets_manager.dart';
import 'package:withtalk_mobile/presentation/styles/app_colors.dart';
import 'package:withtalk_mobile/presentation/styles/app_theme.dart';

class ImageOptionView extends StatelessWidget {
  final Function() camera;
  final Function() gellary;
  const ImageOptionView(
      {super.key, required this.camera, required this.gellary});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: AppTheme.backColor(context),
      ),
      child: Row(
        children: [
          Expanded(
              child: GestureDetector(
            onTap: camera,
            child: Image.asset(
              AssetsManager.icon(name: "camera_option"),
              width: 100,
              height: 100,
              color: AppColors.primaryColor,
            ),
          )),
          Expanded(
              child: GestureDetector(
            onTap: gellary,
            child: Image.asset(
              AssetsManager.icon(name: "gallery_option"),
              width: 100,
              height: 100,
              color: AppColors.primaryColor,
            ),
          )),
        ],
      ),
    );
  }
}
