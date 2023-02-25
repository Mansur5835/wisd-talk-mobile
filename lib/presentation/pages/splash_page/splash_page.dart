import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:withtalk_mobile/core/utils/assets_manager.dart';
import 'package:withtalk_mobile/presentation/pages/intro/intro_page.dart';
import '../../../core/utils/bloc_logic.dart';
import '../../routes/app_navigator.dart';
import '../../styles/app_theme.dart';
import '../choose_language/choose_language_page.dart';
import '../dashboard/dashboard_page.dart';
import 'cubit/splash_cubit.dart';

class SplashPage extends StatefulWidget {
  static const String route = "/";
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final cubit = BlocLogic<SplashCubit>()();

  @override
  void initState() {
    super.initState();
    cubit.loadingUserForm();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, UserCases>(
        listener: (context, state) {
          if (state == UserCases.REGISTERED) {
            AppNavigator.toNamedAndOffAll(DashboardPage.route,
                arguments: cubit.user);
          }

          if (state == UserCases.SELECTED_LANG_ONLY) {
            AppNavigator.toNamedAndOffAll(DashboardPage.route);
          }

          if (state == UserCases.SIGNED_OUT) {
            AppNavigator.toNamedAndOffAll(ChooseLanguagePage.route);
          }
        },
        child: Scaffold(
          backgroundColor: AppTheme.primaryColor(context),
          body: Center(
            child: Image.asset(AssetsManager.icon(name: "wt")),
          ),
        ));
  }
}
