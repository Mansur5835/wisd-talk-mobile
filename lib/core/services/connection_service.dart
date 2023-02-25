import 'package:connectivity_plus/connectivity_plus.dart';

import '../../presentation/components/app_toast.dart';
import '../../presentation/routes/app_navigator.dart';

class AppConnectivity {
  AppConnectivity._();
  final _connectivity = Connectivity();

  bool _refundNetwork = false;

  static final _instance = AppConnectivity._();

  static void initListening() async {
    await Future.delayed(const Duration(seconds: 3));

    _instance._connectivity.onConnectivityChanged
        .listen(_instance.checkNetwork);
  }

  Future _chechSurrentStatus() async {
    return await _connectivity.checkConnectivity();
  }

  checkNetwork(ConnectivityResult result) {
    // if (result == ConnectivityResult.none) {
    //   final _appToast = AppToast();
    //   _appToast.errorToast("Проверьте Интернет",
    //       duration: const Duration(days: 1));
    //   _refundNetwork = true;
    // } else if (_refundNetwork) {
    //   AppNavigator.back();
    //   _refundNetwork = false;
    // }
  }
}
