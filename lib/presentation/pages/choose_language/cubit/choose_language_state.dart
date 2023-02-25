part of 'choose_language_cubit.dart';

class ChooseLanguageState {
  SelectedLang selectedLang;

  ChooseLanguageState([this.selectedLang = SelectedLang.NONE]);

  ChooseLanguageState copyWith(ChooseLanguageState state) {
    return ChooseLanguageState(state.selectedLang);
  }
}
