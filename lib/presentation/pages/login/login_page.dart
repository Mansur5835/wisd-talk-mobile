import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:withtalk_mobile/presentation/components/animation/slide_and_opasity_animation.dart';
import 'package:withtalk_mobile/presentation/components/app_page.dart';
import 'package:withtalk_mobile/presentation/components/app_text.dart';
import 'package:withtalk_mobile/presentation/components/app_text_field.dart';
import 'package:withtalk_mobile/presentation/components/buttons.dart';
import 'package:withtalk_mobile/presentation/pages/login/cubit/login_cubit.dart';
import 'package:withtalk_mobile/presentation/pages/registration/registration_page.dart';
import 'package:withtalk_mobile/presentation/routes/app_navigator.dart';
import 'package:withtalk_mobile/presentation/styles/app_colors.dart';
import 'package:withtalk_mobile/presentation/styles/app_theme.dart';

class LoginPage extends AppPage<LoginCubit, LoginState> {
  static const String route = "/login_page";
  LoginPage({super.key});

  @override
  Widget build(BuildContext context, state) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor(context),
      body: SafeArea(
        child: Container(
          alignment: Alignment.topCenter,
          child: Form(
            key: cubit.fomrKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.all(10),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          AppNavigator.back();
                        },
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Icon(
                            Icons.arrow_back_outlined,
                            color: AppTheme.grey1(context),
                          ),
                          AppText(
                            "back".tr(),
                            color: AppTheme.grey1(context),
                            fontWeight: FontWeight.w600,
                          )
                        ]),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SlideAndOpasityAnimation(
                    opasityDuration: 0,
                    slideDuration: 500,
                    child: _welcomeText(context),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SlideAndOpasityAnimation(
                    opasityDuration: 0,
                    slideDuration: 600,
                    child: _email(),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SlideAndOpasityAnimation(
                    opasityDuration: 0,
                    slideDuration: 700,
                    child: _pass(state),
                  ),
                  SlideAndOpasityAnimation(
                    opasityDuration: 0,
                    slideDuration: 800,
                    child: _loginButton(),
                  ),
                  SlideAndOpasityAnimation(
                    opasityDuration: 900,
                    slideDuration: 0,
                    child: _fogotPass(),
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                  SlideAndOpasityAnimation(
                      opasityDuration: 1000,
                      slideDuration: 0,
                      child: _toRegister(context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _toRegister(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText(
          "dont_you_have_accout".tr(),
          color: AppTheme.grey1(context),
        ),
        TextButton(
            onPressed: () {
              AppNavigator.toNamedAndOff(RegistrationPage.route);
            },
            child: AppText(
              "register".tr(),
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }

  Widget _fogotPass() {
    return TextButton(
        onPressed: () {},
        child: AppText(
          "fogot_pass".tr(),
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
        ));
  }

  Widget _loginButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 55,
      child: PrimaryButton(
        borderRadius: 10,
        onTap: () {
          cubit.login();
        },
        backGroundColor: AppColors.primaryColor,
        title: "login".tr(),
      ),
    );
  }

  Widget _pass(LoginState state) {
    return AppTextField(
      controller: cubit.pass,
      label: "pass".tr(),
      icon: Icons.remove_red_eye,
      iconTab: () {
        cubit.showPass();
      },
      withPass: state.showPas,
      iconColorChangingCondition: false,
      maxLines: 1,
      color: AppColors.primaryColor01,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      radius: 10,
      validator: (pass) {
        if ((pass?.length ?? 0) < 6) {
          return "error_password".tr();
        }
      },
    );
  }

  Widget _email() {
    return AppTextField(
      controller: cubit.email,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      radius: 10,
      label: "email".tr(),
      color: AppColors.primaryColor01,
      validator: (value) {
        // final bool emailValid = RegExp(
        //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        //     .hasMatch(value ?? "");

        // if (!emailValid) {
        //   return "email_error".tr();
        // }
      },
    );
  }

  Widget _welcomeText(BuildContext context) {
    return Column(
      children: [
        AppText(
          "welcome_to_wisdtalk".tr(),
          color: AppTheme.oppositePrimaryColor(context),
          fontWeight: FontWeight.bold,
          size: 23,
        ),
        const SizedBox(
          height: 5,
        ),
        AppText(
          "login_your_account".tr(),
          color: AppTheme.oppositePrimaryColor(context),
          fontWeight: FontWeight.normal,
          size: 18,
        ),
      ],
    );
  }
}
