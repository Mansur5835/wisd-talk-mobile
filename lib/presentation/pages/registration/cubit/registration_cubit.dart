import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:withtalk_mobile/core/services/notification_services.dart';
import 'package:withtalk_mobile/core/utils/dio_utils.dart';
import 'package:withtalk_mobile/data/local_sources/local_storage.dart';
import 'package:withtalk_mobile/main.dart';
import 'package:withtalk_mobile/presentation/components/loading_view_mixin.dart';
import 'package:withtalk_mobile/presentation/pages/dashboard/dashboard_page.dart';
import 'package:withtalk_mobile/presentation/routes/app_navigator.dart';

import '../../../../data/models/user.dart';
import '../../../components/app_cubit.dart';

part 'registration_state.dart';

class RegistrationCubit extends AppCubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationState());

  final GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController conPass = TextEditingController();

  @override
  void init() {
    // TODO: implement init
  }

  showPass() {
    emit(state.copyWith(state..tabPass = !state.tabPass));
  }

  showConPass() {
    emit(state.copyWith(state..tabConfirmPass = !state.tabConfirmPass));
  }

  register() async {
    bool isValid = formKey.currentState?.validate() ?? false;

    if (isValid == false) return;

    loading.showLoading();

    String? deviceId = await NotificationServices().setToken();

    var respnse = await client.registration(
      login: email.text.trim(),
      password: pass.text.trim(),
      repassword: conPass.text.trim(),
      email: email.text.trim(),
      android: io.Platform.isAndroid ? deviceId : null,
      ios: io.Platform.isIOS ? deviceId : null,
    );

    String? token = respnse.data?["token"];

    if (token == null) return loading.hideLoading();

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
  void dispose() {
    // TODO: implement dispose
  }
}
