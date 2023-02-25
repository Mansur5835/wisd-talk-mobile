import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:withtalk_mobile/core/utils/screen_size.dart';
import 'package:withtalk_mobile/presentation/components/app_page.dart';
import 'package:withtalk_mobile/presentation/components/app_text.dart';
import 'package:withtalk_mobile/presentation/components/buttons.dart';
import 'package:withtalk_mobile/presentation/pages/intro/cubit/intro_cubit.dart';
import 'package:withtalk_mobile/presentation/styles/app_colors.dart';

import '../../components/animation/twen_anim.dart';
import '../../routes/app_navigator.dart';
import '../dashboard/dashboard_page.dart';

class IntroPage extends AppPage<IntroCubit, IntroState> {
  static const String route = "/intro_page";
  IntroPage({super.key});

  double size() {
    return ScreenSize.size().height / 2;
  }

  @override
  Widget build(BuildContext context, state) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor1,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            TweenAnim<double>(
                duration: 1000,
                begin: -150,
                end: -30,
                child: (value) {
                  return Positioned(
                      left: -30,
                      top: value,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3123),
                            border: Border.all(
                                width: 10, color: AppColors.backLight)),
                        width: 150,
                        height: 150,
                      ));
                }),
            TweenAnim<double>(
                duration: 1000,
                begin: -150,
                end: -30,
                child: (value) {
                  return Positioned(
                      right: value,
                      top: 85,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3123),
                            border: Border.all(
                                width: 10, color: AppColors.backLight)),
                        width: 100,
                        height: 100,
                      ));
                }),
            _image(state),
            _bottonContainer(state)
          ],
        ),
      ),
    );
  }

  Widget _image(IntroState state) {
    return TweenAnim<double>(
        duration: 700,
        begin: size() - 400,
        end: state.indexChanged ? size() - 400 : size() - 100,
        child: (value) {
          return Positioned(
            right: -70,
            bottom: value,
            child: TweenAnim<double>(
                duration: 700,
                begin: -pi / 10,
                end: state.indexChanged ? -pi / 2 : -pi / 10,
                child: (
                  value,
                ) {
                  return Transform.rotate(
                    angle: value,
                    child: Image.asset(
                      state.image,
                      width: ScreenSize.size().width - 1,
                      height: ScreenSize.size().width - 1,
                    ),
                  );
                }),
          );
        });
  }

  Widget _bottonContainer(IntroState state) {
    return Container(
      alignment: Alignment.bottomRight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: ScreenSize.size().height / 2,
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius:
                const BorderRadius.only(topLeft: Radius.circular(100))),
        child: Column(
          children: [
            _indicator(
              state,
            ),
            TweenAnim<double>(
                duration: 700,
                begin: 50,
                end: state.indexChanged ? 70 : 50,
                child: (value) {
                  return SizedBox(
                    height: value,
                  );
                }),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 700),
              opacity: state.indexChanged ? 0 : 1,
              child: Column(
                children: [
                  AppText(
                    state.title["title"]?.tr(),
                    size: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppText(
                    state.title["body"]?.tr(),
                    size: 18,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.normal,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      AppNavigator.toNamedAndOffAll(DashboardPage.route);
                    },
                    child: AppText(
                      "skip".tr(),
                      color: AppColors.primaryBlack,
                      fontWeight: FontWeight.bold,
                    )),
                const Spacer(),
                CircularButton(
                  onTap: () {
                    cubit.setIndex();
                  },
                  radius: 65,
                  color: AppColors.primaryColor1,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: AppColors.white,
                    child: Icon(
                      Icons.chevron_right_outlined,
                      color: AppColors.primaryColor1,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget _indicator(IntroState state) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: AnimatedSmoothIndicator(
          onDotClicked: (index) {},
          activeIndex: state.index,
          count: 3,
          effect: ExpandingDotsEffect(
              dotWidth: 10,
              expansionFactor: 3,
              activeDotColor: AppColors.primaryColor1,
              dotHeight: 9,
              dotColor: AppColors.primaryBlack03)),
    );
  }
}
