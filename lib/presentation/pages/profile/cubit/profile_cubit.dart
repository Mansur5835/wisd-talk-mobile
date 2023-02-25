import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:withtalk_mobile/core/utils/bloc_logic.dart';
import 'package:withtalk_mobile/core/utils/dio_utils.dart';
import 'package:withtalk_mobile/presentation/components/app_dialog.dart';
import 'package:withtalk_mobile/presentation/components/loading_view_mixin.dart';
import 'package:withtalk_mobile/presentation/components/views/has_not_user_action_view,.dart';
import 'package:withtalk_mobile/presentation/pages/dashboard/cubit/dashboard_cubit.dart';
import 'package:withtalk_mobile/presentation/pages/login/login_page.dart';

import '../../../../data/constants/enums.dart';
import '../../../../data/local_sources/local_storage.dart';
import '../../../../main.dart';
import '../../../components/app_cubit.dart';
import '../../../routes/app_navigator.dart';
import '../../edit_profile/edit_profile_page.dart';

part 'profile_state.dart';

class ProfileCubit extends AppCubit<ProfileState> {
  ProfileCubit() : super(ProfileState());
  final LocalStorage localStorage = LocalStorage();

  @override
  void init() {}

  setlanguage(SelectedLang selectedLang, BuildContext context) async {
    if (selectedLang == SelectedLang.KO) {
      await context.setLocale(const Locale('ko', 'KP'));
      await localStorage.writeData(BoxKeys.LANG_CODE, "ko");
    } else if (selectedLang == SelectedLang.EN) {
      await context.setLocale(const Locale('en', 'US'));
      await localStorage.writeData(BoxKeys.LANG_CODE, "en");
    } else if (selectedLang == SelectedLang.UZ) {
      await context.setLocale(const Locale('uz', 'UZ'));
      await localStorage.writeData(BoxKeys.LANG_CODE, "uz");
    } else {
      await context.setLocale(const Locale('uz', 'UZ'));
      await localStorage.writeData(BoxKeys.LANG_CODE, "uz");
    }

    AppNavigator.back();
  }

  logOut() async {
    localStorage.deleteData(BoxKeys.TOKEN);

    DioUtils.setTokenToHeaders(null);

    AppNavigator.toNamedAndOffAll(LoginPage.route);
  }

  deleteProfile() async {
    await client.editProfile(action: "delete");

    logOut();
  }

  @override
  void dispose() {
    emit(ProfileState());
  }
}
