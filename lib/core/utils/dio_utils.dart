import 'dart:developer';

import 'package:dio/dio.dart';

import '../../data/local_sources/local_storage.dart';
import 'dio_interceptor.dart';

final Dio dio = Dio()
  ..interceptors.addAll(
    [
      CustomInterceptor(),
      // if (withAlice) ...{alice.getDioInterceptor()}
    ],
  );

class DioUtils {
  static Future<void> settingDio() async {
    final LocalStorage localStorage = LocalStorage();

    final token = localStorage.readData<String>(BoxKeys.TOKEN);
    final lang = localStorage.readData(BoxKeys.LANG_CODE);

    setTokenToHeaders(token);
    setLanguageToHeaders(lang);
  }

  static void setTokenToHeaders(String? token) {
    log("Token  : >>>>>>>>>>>> \n ${token.toString()}");
    if (token == null) {
      dio.options.headers.remove("token"); // config your dio headers globally
    } else {
      dio.options.headers["token"] = token.trim();
    }
    dio.options.contentType = Headers.jsonContentType;
    dio.options.responseType = ResponseType.json;
  }

  static void setLanguageToHeaders(String? lang) {
    log("lang  : >>>>>>>>>>>> \n ${lang.toString()}");
    if (lang == null) {
      dio.options.headers.remove("lang"); // config your dio headers globally
    } else {
      dio.options.headers["lang"] = lang;
    }
  }
}
