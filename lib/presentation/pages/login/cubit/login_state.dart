part of 'login_cubit.dart';

class LoginState {
  bool showPas;

  LoginState([this.showPas = true]);

  LoginState coptWith(LoginState state) {
    return LoginState(state.showPas);
  }
}
