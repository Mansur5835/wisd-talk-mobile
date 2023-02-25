import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/local_sources/local_storage.dart';
import '../../../../data/models/app_http_response.dart';
import '../../../../data/models/user.dart';
import '../../../../main.dart';
import '../../../components/loading_view_mixin.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<UserCases> {
  SplashCubit() : super(UserCases.lOADING);
  User? user;

  Future loadingUserForm() async {
    final LocalStorage localStorage = LocalStorage();

    String? token = localStorage.readData(BoxKeys.TOKEN);
    String? lang = localStorage.readData(BoxKeys.LANG_CODE);

    Future.delayed(Duration.zero, () async {
      if (token == null) {
        if (lang != null) {
          emit(UserCases.SELECTED_LANG_ONLY);
          return;
        }
        emit(UserCases.SIGNED_OUT);
        return;
      } else {
        AppHttpResponse? response;
        try {
          response = await client.profile();
        } catch (e) {
          return emit(UserCases.lOADING);
        }

        if (response.data == null) {
          return emit(UserCases.lOADING);
        }

        user = response.data;

        hasUser = true;

        emit(UserCases.REGISTERED);
      }
    }).then((value) {
      appstated = true;
    });
  }
}
