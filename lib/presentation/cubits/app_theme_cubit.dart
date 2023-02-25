import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/local_sources/local_storage.dart';
import '../styles/app_theme.dart';

part 'app_theme_state.dart';

final LocalStorage _localStorage = LocalStorage();

bool isDark = (_localStorage.readData<bool>(BoxKeys.APP_MODE) ?? false);

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit()
      : super(
            AppThemeState(isDark ? AppTheme.dark() : AppTheme.light(), isDark));

  void swicheTheme(bool isDarkMode) async {
    ThemeData themeData = isDarkMode ? AppTheme.dark() : AppTheme.light();

    await _localStorage.writeData(BoxKeys.APP_MODE, isDarkMode);

    emit(state.copyWith(state
      ..themeData = themeData
      ..isDark = isDarkMode));
  }
}
