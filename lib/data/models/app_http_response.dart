import 'package:json_annotation/json_annotation.dart';

part 'app_http_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class AppHttpResponse<T> {
  T? data;
  String? status;
  dynamic message;

  AppHttpResponse({
    required this.data,
    this.message,
    this.status,
  });

  factory AppHttpResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$AppHttpResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$AppHttpResponseToJson(this, toJsonT);
}
