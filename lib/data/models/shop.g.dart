// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopModel _$ShopModelFromJson(Map<String, dynamic> json) => ShopModel(
      json['name'] as String?,
      json['phone'] as String?,
      (json['picture'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['preview_text'] as String?,
      json['address'] as String?,
      json['lat'] as String?,
      json['lon'] as String?,
      (json['rating'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ShopModelToJson(ShopModel instance) => <String, dynamic>{
      'name': instance.name,
      'preview_text': instance.previewText,
      'picture': instance.picture,
      'phone': instance.phone,
      'address': instance.address,
      'lat': instance.lat,
      'lon': instance.lon,
      'rating': instance.rating,
    };
