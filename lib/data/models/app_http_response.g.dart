// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_http_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppHttpResponse<T> _$AppHttpResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    AppHttpResponse<T>(
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      message: json['message'],
      status: json['status'] as String?,
    );

Map<String, dynamic> _$AppHttpResponseToJson<T>(
  AppHttpResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'status': instance.status,
      'message': instance.message,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
