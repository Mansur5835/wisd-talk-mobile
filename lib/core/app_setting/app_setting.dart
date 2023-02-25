import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/local_sources/initial_lang.dart';
import '../services/connection_service.dart';
import '../services/notification_services.dart';
import '../services/remote_confic.dart';

abstract class _AppSettingAbstract {
  String initial(BuildContext context);

  Future<void> appOnReady();
}

class AppSetting extends _AppSettingAbstract {
  @override
  Future<void> appOnReady() async {
    AppConnectivity.initListening();
    CheckAppVersionService.instance.init();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // NotificationServices().setToken();
  }

  @override
  String initial(BuildContext context) {
    {
      appOnReady();

      InitialLang()(context);

      return "WisdTalk";
    }
  }

  String call(BuildContext context) {
    return initial(context);
  }
}
