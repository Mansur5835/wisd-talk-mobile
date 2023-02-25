// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cotegory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CotegoryModel _$CotegoryModelFromJson(Map<String, dynamic> json) =>
    CotegoryModel(
      json['category_id'] as String?,
      json['name'] as String?,
      json['icon'] as String?,
    );

Map<String, dynamic> _$CotegoryModelToJson(CotegoryModel instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'name': instance.name,
      'icon': instance.icon,
    };
