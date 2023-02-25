import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'local_storage.dart';

class InitialLang {
  call(BuildContext context) {
    final localStorage = LocalStorage();
    final langCode = localStorage.readData<String>(BoxKeys.LANG_CODE);

    switch (langCode) {
      case "uz":
        context.setLocale(const Locale("uz", "UZ"));
        break;
      case "ko":
        context.setLocale(const Locale("ko", "KP"));
        break;
      case "en":
        context.setLocale(const Locale("en", "US"));
        break;

      case null:
        context.setLocale(const Locale("ko", "KP"));
        break;
    }
  }
}
