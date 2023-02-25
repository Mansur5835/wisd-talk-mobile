// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'furniture_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FurnitureDetailModel _$FurnitureDetailModelFromJson(
        Map<String, dynamic> json) =>
    FurnitureDetailModel(
      json['material'] as String?,
      json['color'] as String?,
      json['installment'] as String?,
      json['meshanism'] as String?,
      json['model'] as String?,
      json['style'] as String?,
      json['name'] as String?,
      json['shop'] as String?,
      (json['image'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['video'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['rating'] as num?)?.toDouble(),
      json['sold'] as int?,
      json['fav'] as bool?,
      json['name_model'] as String?,
      json['phone'] as String?,
      json['preview_text'] as String?,
      json['price'] as String?,
      json['production'] as String?,
      (json['review_count'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$FurnitureDetailModelToJson(
        FurnitureDetailModel instance) =>
    <String, dynamic>{
      'preview_text': instance.previewText,
      'name': instance.name,
      'image': instance.image,
      'video': instance.video,
      'sold': instance.sold,
      'shop': instance.shop,
      'rating': instance.rating,
      'review_count': instance.reviewCount,
      'fav': instance.fav,
      'name_model': instance.nameModel,
      'production': instance.production,
      'model': instance.model,
      'color': instance.color,
      'style': instance.style,
      'meshanism': instance.meshanism,
      'installment': instance.installment,
      'material': instance.material,
      'price': instance.price,
      'phone': instance.phone,
    };
