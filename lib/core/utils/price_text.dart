import 'package:easy_localization/easy_localization.dart';

class PriceText {
  static String? UZS(String? price, [String? type]) {
    if (price == null || price.isEmpty) {
      return "0  ${(type ?? "sum").tr()}";
    }

    switch (price.length) {
      case 4:
        return "${price[0]} ${price.substring(1, 4)} ${(type ?? "sum").tr()}";
      case 5:
        return "${price.substring(0, 2)} ${price.substring(2, 5)} ${(type ?? "sum").tr()}";
      case 6:
        return "${price.substring(0, 3)} ${price.substring(3, 6)} ${(type ?? "sum").tr()}";
      case 7:
        return "${price.substring(0, 1)} ${price.substring(1, 4)} ${price.substring(4, 7)} ${(type ?? "sum").tr()}";
      case 8:
        return "${price.substring(0, 2)} ${price.substring(2, 5)} ${price.substring(5, 8)} ${"sum".tr()}";
    }
    return "$price  ${(type ?? "sum").tr()}";
  }

  static String? WITHOUT_UZS(String? price) {
    if (price == null || price.isEmpty) {
      return "0";
    }

    switch (price.length) {
      case 4:
        return "${price[0]} ${price.substring(1, 4)} ${"sum".tr()}";
      case 5:
        return "${price.substring(0, 2)} ${price.substring(2, 5)} ${"sum".tr()}";
      case 6:
        return "${price.substring(0, 3)} ${price.substring(3, 6)} ${"sum".tr()}";
      case 7:
        return "${price.substring(0, 1)} ${price.substring(1, 4)} ${price.substring(4, 7)} ${"sum".tr()}";
      case 8:
        return "${price.substring(0, 2)} ${price.substring(2, 5)} ${price.substring(5, 8)} ${"sum".tr()}";
    }
    return "$price ${"sum".tr()}";
  }
}
