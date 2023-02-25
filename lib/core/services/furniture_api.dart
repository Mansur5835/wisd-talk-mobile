import 'dart:convert';

import 'package:http/http.dart' as http;

class PhotoApi {
  static Future<List<dynamic>?> GET(String api) async {
    final response =
        await http.get(Uri.parse("https://api.unsplash.com$api"), headers: {
      "Authorization": 'Client-ID RXFnVFDtZ63maGJGpm-0wmAGRhg-xFUEv58LRaFT9fc',
      "Accept-Version": "v1"
    });

    if (response.statusCode != 200) {
      return null;
    }
    List<dynamic> listMap = jsonDecode(response.body);
    return listMap;
  }

  static Future<List<dynamic>?> GETS(String api) async {
    final response =
        await http.get(Uri.parse("https://api.unsplash.com$api"), headers: {
      "Authorization": 'Client-ID RXFnVFDtZ63maGJGpm-0wmAGRhg-xFUEv58LRaFT9fc',
      "Accept-Version": "v1"
    });

    if (response.statusCode != 200) {
      return null;
    }
    List<dynamic> listMap = jsonDecode(response.body)["results"];
    return listMap;
  }
}
