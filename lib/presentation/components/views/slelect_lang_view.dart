import 'package:flutter/material.dart';

import '../../../core/utils/assets_manager.dart';
import '../../../data/constants/enums.dart';
import '../../styles/app_theme.dart';
import '../animation/slide_and_opasity_animation.dart';
import '../app_text.dart';

class SelctLangView extends StatelessWidget {
  SelctLangView({super.key, required this.onTap});
  final Function(SelectedLang selectedLang) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backColor(context),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SlideAndOpasityAnimation(
            opasityDuration: 0,
            slideDuration: 500,
            child: _langItem(
              AssetsManager.images(name: "flag_uz", format: "jpeg"),
              "O`zbek",
              context,
              SelectedLang.UZ,
            ),
          ),
          SlideAndOpasityAnimation(
            opasityDuration: 0,
            slideDuration: 600,
            child: _langItem(
                AssetsManager.images(
                  name: "flag_en",
                ),
                "English",
                context,
                SelectedLang.EN),
          ),
          SlideAndOpasityAnimation(
            opasityDuration: 0,
            slideDuration: 700,
            child: _langItem(AssetsManager.images(name: "flag_ko"), "한국어",
                context, SelectedLang.KO),
          ),
        ],
      ),
    );
  }

  Widget _langItem(String image, String title, BuildContext context,
      SelectedLang selectedLang) {
    return GestureDetector(
      onTap: () {
        onTap(selectedLang);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3123),
              child: Image.asset(
                image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          AppText(
            title,
            color: AppTheme.oppositePrimaryColor(context),
          )
        ],
      ),
    );
  }
}
