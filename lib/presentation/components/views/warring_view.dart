import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:withtalk_mobile/presentation/components/app_text.dart';

import '../../styles/app_colors.dart';
import '../../styles/app_theme.dart';
import '../animation/slide_and_opasity_animation.dart';
import '../buttons.dart';

class WarringView extends StatelessWidget {
  const WarringView(
      {super.key,
      required this.warningText,
      required this.yes,
      required this.no});
  final String warningText;
  final Function() yes;
  final Function() no;

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
                height: 180,
                decoration: BoxDecoration(
                    color: AppTheme.backColor(context),
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      AppText(
                        warningText,
                        color: AppTheme.oppositePrimaryColor(context),
                        size: 18,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w700,
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 50,
                        child: PrimaryButton(
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          backGroundColor: AppColors.primaryColor,
                          borderRadius: 10,
                          title: "yes".tr(),
                          onTap: () {
                            yes();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      AppOutlinedButton(
                        size: const Size(double.infinity, 50),
                        color: AppColors.primaryColor,
                        label: "no".tr(),
                        borderRadius: 10,
                        onTap: () {
                          no();
                        },
                      ),
                    ],
                  ),
                ))));
  }
}
