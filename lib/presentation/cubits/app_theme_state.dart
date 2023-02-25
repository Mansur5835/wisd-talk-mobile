part of 'app_theme_cubit.dart';

class AppThemeState {
  ThemeData? themeData;
  bool isDark;

  AppThemeState([this.themeData, this.isDark = false]);

  AppThemeState copyWith(AppThemeState state) {
    return AppThemeState(state.themeData, state.isDark);
  }
}
