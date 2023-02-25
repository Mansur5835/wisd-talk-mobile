import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:withtalk_mobile/presentation/components/animation/slide_and_opasity_animation.dart';
import 'package:withtalk_mobile/presentation/components/app_page.dart';
import 'package:withtalk_mobile/presentation/components/app_text.dart';
import 'package:withtalk_mobile/presentation/components/app_text_field.dart';
import 'package:withtalk_mobile/presentation/components/buttons.dart';
import 'package:withtalk_mobile/presentation/pages/login/login_page.dart';
import 'package:withtalk_mobile/presentation/pages/registration/cubit/registration_cubit.dart';
import 'package:withtalk_mobile/presentation/routes/app_navigator.dart';
import 'package:withtalk_mobile/presentation/styles/app_colors.dart';
import 'package:withtalk_mobile/presentation/styles/app_theme.dart';

class RegistrationPage extends AppPage<RegistrationCubit, RegistrationState> {
  static const String route = "/registration_page";
  RegistrationPage({super.key});

  @override
  Widget build(BuildContext context, state) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor(context),
      body: SafeArea(
        child: Form(
          key: cubit.formKey,
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
                  child: _wecomeText(context),
                ),
                const SizedBox(
                  height: 50,
                ),
                SlideAndOpasityAnimation(
                  opasityDuration: 0,
                  slideDuration: 600,
                  child: _name(),
                ),
                SlideAndOpasityAnimation(
                  opasityDuration: 0,
                  slideDuration: 700,
                  child: _email(),
                ),
                SlideAndOpasityAnimation(
                  opasityDuration: 0,
                  slideDuration: 800,
                  child: _pass(state),
                ),
                const SizedBox(
                  height: 15,
                ),
                SlideAndOpasityAnimation(
                  opasityDuration: 0,
                  slideDuration: 900,
                  child: _conPass(state),
                ),
                const SizedBox(
                  height: 15,
                ),
                SlideAndOpasityAnimation(
                  opasityDuration: 0,
                  slideDuration: 1000,
                  child: _registerButton(),
                ),
                const SizedBox(
                  height: 100,
                ),
                SlideAndOpasityAnimation(
                  opasityDuration: 1000,
                  slideDuration: 0,
                  child: _toLogin(context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _toLogin(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText(
          "have_you_account".tr(),
          color: AppTheme.grey1(context),
        ),
        TextButton(
            onPressed: () {
              AppNavigator.toNamedAndOff(LoginPage.route);
            },
            child: AppText(
              "${"login".tr()}!",
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }

  Widget _registerButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 55,
      child: PrimaryButton(
        onTap: () {
          cubit.register();
        },
        borderRadius: 10,
        backGroundColor: AppColors.primaryColor,
        title: "register".tr(),
      ),
    );
  }

  Widget _conPass(RegistrationState state) {
    return AppTextField(
      controller: cubit.conPass,
      withPass: state.tabConfirmPass,
      iconTab: () {
        cubit.showConPass();
      },
      label: "confirm_pass".tr(),
      iconColorChangingCondition: false,
      color: AppColors.primaryColor01,
      icon: Icons.remove_red_eye,
      maxLines: 1,
      validator: (pass) {
        if (pass != cubit.pass.text.trim()) {
          return "error_confirm_password".tr();
        }
      },
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      radius: 10,
    );
  }

  Widget _pass(RegistrationState state) {
    return AppTextField(
      controller: cubit.pass,
      label: "pass".tr(),
      iconTab: () {
        cubit.showPass();
      },
      withPass: state.tabPass,
      iconColorChangingCondition: false,
      icon: Icons.remove_red_eye,
      maxLines: 1,
      color: AppColors.primaryColor01,
      validator: (pass) {
        if ((pass?.length ?? 0) < 6) {
          return "error_password".tr();
        }
      },
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      radius: 10,
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
        final bool emailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value ?? "");

        if (!emailValid) {
          return "email_error".tr();
        }
      },
    );
  }

  Widget _name() {
    return AppTextField(
      controller: cubit.name,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      radius: 10,
      label: "full_name".tr(),
      color: AppColors.primaryColor01,
      validator: (name) {
        if ((name?.length ?? 0) < 3) {
          return "name_error".tr();
        }
      },
    );
  }

  Widget _wecomeText(BuildContext context) {
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
          "create_your_account".tr(),
          color: AppTheme.oppositePrimaryColor(context),
          fontWeight: FontWeight.normal,
          size: 18,
        ),
      ],
    );
  }
}
