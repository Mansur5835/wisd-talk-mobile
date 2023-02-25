import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class UploadFiles {
  static FormData getImagesOnData(List<File> files) {
    final _data = FormData();
    int count = -1;

    _data.files.addAll(List.generate(files.length, (index) {
      count++;
      return MapEntry(
          "more_photo[$count]",
          MultipartFile.fromFileSync(
            files[index].path,
            filename: files[index].path.split(Platform.pathSeparator).last,
            contentType: MediaType.parse('image/jpeg'),
          ));
    }));

    return _data;
  }
}
