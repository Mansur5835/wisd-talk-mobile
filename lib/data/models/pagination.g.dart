// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pagination<T> _$PaginationFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    Pagination<T>(
      (json['info'] as List<dynamic>?)?.map(fromJsonT).toList(),
      json['pagination'] == null
          ? null
          : PaginationCounter.fromJson(
              json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaginationToJson<T>(
  Pagination<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'info': instance.info?.map(toJsonT).toList(),
      'pagination': instance.pagination?.toJson(),
    };
