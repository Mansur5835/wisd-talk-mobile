class AssetsManager {
  static String icon({required String name, String? format}) {
    return "assets/icons/$name.${format ?? "png"}";
  }

  static String images({required String name, String? format}) {
    return "assets/images/$name.${format ?? "png"}";
  }

  static String lottie({required String name, String? format}) {
    return "assets/lotties/$name.${format ?? "json"}";
  }

  static String audio({required String name, String? format}) {
    return "assets/audio/$name.${format ?? "mp3"}";
  }
}
