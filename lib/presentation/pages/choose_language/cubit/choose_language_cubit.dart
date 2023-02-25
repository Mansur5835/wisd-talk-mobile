import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:withtalk_mobile/presentation/pages/intro/intro_page.dart';
import 'package:withtalk_mobile/presentation/routes/app_navigator.dart';

import '../../../../data/constants/enums.dart';
import '../../../../data/local_sources/local_storage.dart';
import '../../../../main.dart';
import '../../../components/app_cubit.dart';

part 'choose_language_state.dart';

class ChooseLanguageCubit extends AppCubit<ChooseLanguageState> {
  ChooseLanguageCubit() : super(ChooseLanguageState());

  @override
  void init() {
    // TODO: implement init
  }

  setlanguage(SelectedLang selectedLang) async {
    final LocalStorage localStorage = LocalStorage();

    if (selectedLang == SelectedLang.KO) {
      await navigatorKey.currentContext!.setLocale(const Locale('ko', 'KP'));
      await localStorage.writeData(BoxKeys.LANG_CODE, "ko");
    } else if (selectedLang == SelectedLang.EN) {
      await navigatorKey.currentContext!.setLocale(const Locale('en', 'US'));
      await localStorage.writeData(BoxKeys.LANG_CODE, "en");
    } else if (selectedLang == SelectedLang.UZ) {
      await navigatorKey.currentContext!.setLocale(const Locale('uz', 'UZ'));
      await localStorage.writeData(BoxKeys.LANG_CODE, "uz");
    } else {
// ignore: use_build_context_synchronously
      await navigatorKey.currentContext!.setLocale(const Locale('uz', 'UZ'));
      await localStorage.writeData(BoxKeys.LANG_CODE, "uz");
    }

    AppNavigator.toNamedAndOffAll(IntroPage.route);
  }

  @override
  void dispose() {}
}
