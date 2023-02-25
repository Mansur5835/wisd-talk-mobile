// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_counter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationCounter _$PaginationCounterFromJson(Map<String, dynamic> json) =>
    PaginationCounter(
      json['current_page'] as int?,
      json['page_count'] as int?,
      json['page_size'] as int?,
      json['total_count'] as int?,
    );

Map<String, dynamic> _$PaginationCounterToJson(PaginationCounter instance) =>
    <String, dynamic>{
      'total_count': instance.totalCount,
      'page_size': instance.pageSize,
      'current_page': instance.currentPage,
      'page_count': instance.pageCount,
    };
