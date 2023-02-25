import 'package:easy_localization/easy_localization.dart';

class DataFormater {
  static String? toMobileDate(String? date) {
    if (date == null) return null;

    ///21.11.1991
    ///

    return date.replaceAll(".", "/");
  }

  static String? toServerDate(String? date) {
    if (date == null) return null;

    ///21/11/1991
    ///

    return date.replaceAll("/", ".");
  }

  static String? toMobilePhone(String? phone) {
    if (phone == null) return null;

    //  998998151588

    return "+998$phone";
  }

  static String? dateToMobile(String? date) {
    //2023.01.28

    if (date == null) return null;

    List<String> dateInList = date.split(".");

    String year = dateInList[0];
    String day = dateInList[2];
    String month = dateInList[1];

    switch (int.parse(month)) {
      case 1:
        month = "january".tr();
        break;
      case 2:
        month = "february".tr();
        break;
      case 3:
        month = "march".tr();
        break;
      case 4:
        month = "april".tr();
        break;
      case 5:
        month = "may".tr();
        break;
      case 6:
        month = "june".tr();
        break;
      case 7:
        month = "july".tr();
        break;
      case 8:
        month = "august".tr();
        break;
      case 9:
        month = "september".tr();
        break;
      case 10:
        month = "october".tr();
        break;
      case 11:
        month = "november".tr();
        break;
      case 12:
        month = "december".tr();
        break;
    }

    return "$day-$month, $year";
  }
}
