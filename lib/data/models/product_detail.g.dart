// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailModel _$ProductDetailModelFromJson(Map<String, dynamic> json) =>
    ProductDetailModel(
      json['id'] as String?,
      json['name'] as String?,
      json['phone'] as String?,
      json['address'] as String?,
      json['like'] as bool?,
      json['price'] as String?,
      json['date'] as String?,
      json['more_photo'] as List<dynamic>?,
      json['detail_text'] as String?,
      (json['reting'] as num?)?.toDouble(),
      json['user_id'] as String?,
      json['user'] as String?,
      json['count'] as String?,
      json['user_photo'] as String?,
      json['parent_section_id'] as String?,
      json['section_id'] as String?,
    );

Map<String, dynamic> _$ProductDetailModelToJson(ProductDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'detail_text': instance.detailText,
      'price': instance.price,
      'address': instance.address,
      'phone': instance.phone,
      'reting': instance.reting,
      'date': instance.date,
      'like': instance.like,
      'more_photo': instance.morePhotos,
      'user_id': instance.userId,
      'user': instance.userName,
      'user_photo': instance.userPhoto,
      'count': instance.count,
      'parent_section_id': instance.parentSectionId,
      'section_id': instance.sectionId,
    };
