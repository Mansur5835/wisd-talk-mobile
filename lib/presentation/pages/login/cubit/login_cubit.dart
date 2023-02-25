import 'package:flutter/material.dart';
import 'package:withtalk_mobile/core/services/notification_services.dart';
import 'package:withtalk_mobile/presentation/components/app_cubit.dart';
import 'package:withtalk_mobile/presentation/components/loading_view_mixin.dart';
import 'dart:io' as io;
import '../../../../core/utils/dio_utils.dart';
import '../../../../data/local_sources/local_storage.dart';
import '../../../../data/models/user.dart';
import '../../../../main.dart';
import '../../../routes/app_navigator.dart';
import '../../dashboard/dashboard_page.dart';

part 'login_state.dart';

class LoginCubit extends AppCubit<LoginState> {
  LoginCubit() : super(LoginState());

  GlobalKey<FormState> fomrKey = GlobalKey();

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  showPass() {
    emit(state.coptWith(state..showPas = !state.showPas));
  }

  login() async {
    bool isValid = fomrKey.currentState?.validate() ?? false;

    if (!isValid) return;

    loading.showLoading();

    String? deviceId = await NotificationServices().setToken();

    var response = await client.login(
      login: email.text.trim(),
      password: pass.text.trim(),
      android: io.Platform.isAndroid ? deviceId : null,
      ios: io.Platform.isIOS ? deviceId : null,
    );

    String? token = response.data?["token"];

    if (token == null) {
      return;
    }

    LocalStorage localStorage = LocalStorage();

    DioUtils.setTokenToHeaders(token);

    localStorage.writeData(BoxKeys.TOKEN, token);

    var profile = await client.profile();

    if (profile.data == null) {
      return;
    }

    User? user = profile.data;

    loading.hideLoading();

    hasUser = true;

    AppNavigator.toNamedAndOffAll(DashboardPage.route, arguments: user);
  }

  @override
  void init() {
    // TODO: implement init
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
