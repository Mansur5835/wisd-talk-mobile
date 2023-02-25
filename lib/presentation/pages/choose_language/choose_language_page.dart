import 'package:flutter/material.dart';
import 'package:withtalk_mobile/core/utils/assets_manager.dart';
import 'package:withtalk_mobile/data/constants/enums.dart';
import 'package:withtalk_mobile/presentation/components/animation/slide_and_opasity_animation.dart';
import 'package:withtalk_mobile/presentation/components/app_page.dart';
import 'package:withtalk_mobile/presentation/components/app_text.dart';
import 'package:withtalk_mobile/presentation/components/buttons.dart';
import 'package:withtalk_mobile/presentation/pages/choose_language/cubit/choose_language_cubit.dart';
import 'package:withtalk_mobile/presentation/styles/app_colors.dart';

class ChooseLanguagePage
    extends AppPage<ChooseLanguageCubit, ChooseLanguageState> {
  static const String route = '/choose_language_page';
  ChooseLanguagePage({super.key});

  @override
  Widget build(BuildContext context, state) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SlideAndOpasityAnimation(
                slideDuration: 0,
                opasityDuration: 500,
                child: _chooseItem(
                    AssetsManager.images(name: "flag_uz", format: "jpeg"),
                    "O`zbek", onTab: () {
                  cubit.setlanguage(SelectedLang.UZ);
                }),
              ),
              SlideAndOpasityAnimation(
                slideDuration: 0,
                opasityDuration: 600,
                child: _chooseItem(
                    AssetsManager.images(name: "flag_en", format: "png"),
                    "English", onTab: () {
                  cubit.setlanguage(SelectedLang.EN);
                }),
              ),
              SlideAndOpasityAnimation(
                slideDuration: 0,
                opasityDuration: 700,
                child: _chooseItem(
                    AssetsManager.images(name: "flag_ko", format: "png"), "한국어",
                    onTab: () {
                  cubit.setlanguage(SelectedLang.KO);
                }),
              ),
            ],
          ),
        ));
  }

  Widget _chooseItem(String image, String title, {Function? onTab}) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: CustomButton(
        onTap: onTab,
        color: AppColors.primaryColor,
        borderRadius: 15,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(123123),
              child: Image.asset(
                image,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            AppText(
              title,
              color: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
