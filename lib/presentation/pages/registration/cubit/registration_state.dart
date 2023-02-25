part of 'registration_cubit.dart';

class RegistrationState {
  bool tabPass;
  bool tabConfirmPass;
  RegistrationState([
    this.tabConfirmPass = true,
    this.tabPass = true,
  ]);

  RegistrationState copyWith(RegistrationState state) {
    return RegistrationState(state.tabConfirmPass, state.tabPass);
  }
}
