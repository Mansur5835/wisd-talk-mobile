import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../pages/registration/registration_page.dart';
import '../../routes/app_navigator.dart';
import '../../styles/app_colors.dart';
import '../../styles/app_theme.dart';
import '../animation/slide_and_opasity_animation.dart';
import '../app_text.dart';
import '../buttons.dart';

class HasNotUserAvtionView extends StatelessWidget {
  const HasNotUserAvtionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      alignment: Alignment.bottomCenter,
      child: SlideAndOpasityAnimation(
        opasityDuration: 200,
        slideDuration: 500,
        curve: Curves.fastOutSlowIn,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(10),
          height: 220,
          decoration: BoxDecoration(
              color: AppTheme.backColor(context),
              borderRadius: BorderRadius.circular(10)),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                AppText(
                  "please_login".tr(),
                  color: AppTheme.oppositePrimaryColor(context),
                  size: 18,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w700,
                ),
                const Spacer(),
                SizedBox(
                  height: 50,
                  child: PrimaryButton(
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    backGroundColor: AppColors.primaryColor,
                    borderRadius: 10,
                    title: "register".tr(),
                    onTap: () {
                      AppNavigator.toNamed(RegistrationPage.route);
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                AppOutlinedButton(
                  size: const Size(double.infinity, 50),
                  color: AppColors.primaryColor,
                  label: "later".tr(),
                  borderRadius: 10,
                  onTap: () {
                    AppNavigator.back();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
