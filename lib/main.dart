import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:withtalk_mobile/presentation/bloc_providers/providers.dart';
import 'package:withtalk_mobile/presentation/cubits/app_theme_cubit.dart';
import 'package:withtalk_mobile/presentation/pages/splash_page/splash_page.dart';
import 'package:withtalk_mobile/presentation/routes/routes.dart';

import 'core/app_setting/app_init.dart';
import 'core/app_setting/app_setting.dart';
import 'data/constants/languages_code.dart';

final navigatorKey = GlobalKey<NavigatorState>();
bool appstated = false;
bool hasUser = false;

void main(List<String> args) async {
  await AppInit.init();

  runApp(
    EasyLocalization(
        supportedLocales: supportedLocales,
        path: "lib/data/local_sources/localization",
        fallbackLocale: const Locale('uz', 'UZ'),
        child: const MyApp()),
  );
}

//9860 3501 0185 3306

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers(context),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: BlocBuilder<AppThemeCubit, AppThemeState>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: state.themeData,
              onGenerateTitle: AppSetting(),
              navigatorKey: navigatorKey,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              initialRoute: SplashPage.route,
              onGenerateRoute: RouteManager.generateRoute,
            );
          },
        ),
      ),
    );
  }
}
