import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:withtalk_mobile/main.dart';
import 'package:withtalk_mobile/presentation/components/animation/slide_and_opasity_animation.dart';
import 'package:withtalk_mobile/presentation/components/app_bottom_sheet.dart';
import 'package:withtalk_mobile/presentation/components/app_dialog.dart';
import 'package:withtalk_mobile/presentation/components/app_network_image.dart';
import 'package:withtalk_mobile/presentation/components/app_page.dart';
import 'package:withtalk_mobile/presentation/components/app_text.dart';
import 'package:withtalk_mobile/presentation/components/buttons.dart';
import 'package:withtalk_mobile/presentation/components/views/profile_item_view.dart';
import 'package:withtalk_mobile/presentation/components/views/warring_view.dart';
import 'package:withtalk_mobile/presentation/cubits/app_theme_cubit.dart';
import 'package:withtalk_mobile/presentation/pages/dashboard/cubit/dashboard_cubit.dart';
import 'package:withtalk_mobile/presentation/pages/edit_profile/edit_profile_page.dart';
import 'package:withtalk_mobile/presentation/pages/my_forum/forum_list/my_forum_page.dart';
import 'package:withtalk_mobile/presentation/pages/profile/cubit/profile_cubit.dart';
import 'package:withtalk_mobile/presentation/pages/registration/registration_page.dart';
import 'package:withtalk_mobile/presentation/routes/app_navigator.dart';
import 'package:withtalk_mobile/presentation/styles/app_colors.dart';
import 'package:withtalk_mobile/presentation/styles/app_theme.dart';
import '../../components/views/has_not_user_action_view,.dart';
import '../../components/views/slelect_lang_view.dart';
import '../../components/views/user_avatar.dart';
import '../user_self_announ/user_self_announ_page.dart';

class ProfilePage extends AppPage<ProfileCubit, ProfileState> {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context, state) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, _state) {
        return Scaffold(
          backgroundColor: AppTheme.primaryColor(context),
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: AppTheme.primaryColor(context),
            title: AppText(
              "profile".tr(),
              color: AppTheme.oppositePrimaryColor(context),
              fontWeight: FontWeight.bold,
            ),
          ),
          body: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _userAccount(context, state, _state),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  alignment: Alignment.centerLeft,
                  child: AppText(
                    "preferences".tr(),
                    color: AppTheme.oppositePrimaryColor(context),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 3,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: AppTheme.backColor(context),
                ),
                _preferences(state, context)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _userAccount(
      BuildContext context, ProfileState state, DashboardState dashState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _photo(state),
        const SizedBox(
          height: 5,
        ),
        if (hasUser)
          Container(
            alignment: Alignment.center,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  AppNavigator.toNamed(UserSelfAnnounPage.route, arguments: {
                    "title": "my_announcement".tr(),
                    "user": false
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(
                      "my_announcement".tr(),
                      color: AppTheme.oppositePrimaryColor(context),
                      size: 15,
                    ),
                    Icon(
                      Icons.navigate_next_rounded,
                      color: AppTheme.oppositePrimaryColor(context),
                    )
                  ],
                ),
              ),
            ),
          ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
          child: CustomButton(
            onTap: () {
              if (hasUser) {
                AppNavigator.toNamed(EditProfilePage.route,
                    arguments: dashState.user);
              } else {
                AppNavigator.toNamed(RegistrationPage.route);
              }
            },
            borderRadius: 10,
            color: AppColors.primaryColor,
            hiegth: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (hasUser)
                  AppText("edit_profile".tr())
                else
                  AppText("register".tr()),
                const Icon(Icons.chevron_right_rounded)
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _photo(ProfileState state) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, dashState) {
        return Hero(
          tag: "profile_image",
          child: Container(
              child: dashState.user?.photo == null
                  ? UserAvatar()
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(23423),
                      child: AppNetworkImage(
                        url: dashState.user?.photo,
                        wight: 90,
                        height: 90,
                      ),
                    )),
        );
      },
    );
  }

  Widget _preferences(ProfileState state, BuildContext context) {
    return Column(children: [
      BlocBuilder<AppThemeCubit, AppThemeState>(
        builder: (context, state) {
          return SlideAndOpasityAnimation(
            opasityDuration: 0,
            slideDuration: 500,
            child: ProfileItemView(
              icon: "night-mode",
              title: "dark_mode".tr(),
              trailing: CupertinoSwitch(
                  activeColor: AppColors.primaryColor,
                  value: state.isDark,
                  onChanged: (value) {
                    BlocProvider.of<AppThemeCubit>(context).swicheTheme(value);
                    // setState(() {});
                  }),
            ),
          );
        },
      ),
      SlideAndOpasityAnimation(
        opasityDuration: 0,
        slideDuration: 600,
        child: ProfileItemView(
          onTab: () {
            AppBottomSheet(
                    withTitle: false,
                    child: SelctLangView(
                      onTap: (selectedLang) {
                        cubit.setlanguage(selectedLang, context);
                      },
                    ),
                    height: 200)
                .show();
          },
          icon: "language",
          title: "language".tr(),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                "your_language".tr(),
                color: AppTheme.oppositePrimaryColor(context),
              ),
              Icon(
                Icons.chevron_right_outlined,
                color: AppTheme.oppositePrimaryColor(context),
              ),
            ],
          ),
        ),
      ),
      if (hasUser)
        SlideAndOpasityAnimation(
          opasityDuration: 0,
          slideDuration: 700,
          child: ProfileItemView(
            onTab: () {
              AppNavigator.toNamed(MyForumPage.route);
            },
            icon: "forum",
            title: "forums".tr(),
          ),
        ),
      SlideAndOpasityAnimation(
        opasityDuration: 0,
        slideDuration: 800,
        child: ProfileItemView(
          onTab: () {
            if (!hasUser) {
              return const AppDialog(child: HasNotUserAvtionView()).show();
            }

            AppDialog(
                child: WarringView(
              no: () {
                AppNavigator.back();
              },
              yes: () {
                cubit.deleteProfile();
              },
              warningText: "are_you_deleting_your_profile".tr(),
            )).show();
          },
          icon: "delete-user",
          color: AppColors.red,
          title: "delete_profile".tr(),
          trailing: Container(
            width: 10,
          ),
        ),
      ),
      SlideAndOpasityAnimation(
        opasityDuration: 0,
        slideDuration: 900,
        child: ProfileItemView(
          onTab: () {
            if (!hasUser) {
              return const AppDialog(child: HasNotUserAvtionView()).show();
            }

            AppDialog(
                child: WarringView(
              no: () {
                AppNavigator.back();
              },
              yes: () {
                cubit.logOut();
              },
              warningText: "are_you_logouting".tr(),
            )).show();
          },
          icon: "exit",
          title: "log_out".tr(),
          color: AppColors.red,
          trailing: Container(
            width: 10,
          ),
        ),
      ),
    ]);
  }
}
