import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../data/models/app_http_response.dart';
import '../../main.dart';
import '../../presentation/components/app_toast.dart';
import '../../presentation/components/loading_view_mixin.dart';
import '../../presentation/routes/app_navigator.dart';

class CustomInterceptor extends dio.Interceptor {
  final Logger logger = Logger();

  @override
  void onResponse(dio.Response response, ResponseInterceptorHandler handler) {
    // ignore: prefer_interpolation_to_compose_strings
    logger.i("RESPONSE >>>> " +
        response.requestOptions.uri.toString() +
        "\n headers : " +
        response.requestOptions.headers.values.toString() +
        "\n body : " +
        (response.data).toString() +
        "\n param : " +
        response.requestOptions.queryParameters.toString());

    handler.next(response);
  }

  @override
  void onRequest(
      dio.RequestOptions options, dio.RequestInterceptorHandler handler) {
    // ignore: prefer_interpolation_to_compose_strings
    logger.i("REQUEST >>>> " +
        options.uri.toString() +
        "\n headers : " +
        options.headers.values.toString() +
        "\n body : " +
        options.data.toString() +
        "\n param : " +
        options.queryParameters.toString());
    handler.next(options);
  }

  @override
  Future onError(dio.DioError err, dio.ErrorInterceptorHandler handler) async {
    if (!appstated) {
      return handler.next(err);
    }

    if (loading.isLoading) {
      AppNavigator.back();
    }

    logger.e(err.message.toString());

    AppToast appToast = AppToast();
    AppHttpResponse? response;

    try {
      response = AppHttpResponse.fromJson(err.response?.data, (object) {});
    } catch (e) {}

    if (err.response?.statusCode == 500) {
      appToast.errorToast(response?.message ?? err.message);
      return handler.resolve(
          Response(requestOptions: err.requestOptions, data: {"data": null}));
    }

    if (err.response?.statusCode == 401) {
      appToast.errorToast(response?.message ?? err.message);
      return handler.resolve(err.response!);
    }

    if (err.response?.statusCode == 403) {
      appToast.errorToast(response?.message ?? err.message);
      return handler.resolve(err.response!);
    }

    if (err.response?.statusCode == 404) {
      appToast.errorToast(response?.message ?? err.message);
      return handler.resolve(err.response!);
    }

    return handler.next(err); // <--- THE TIP IS HERE
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
