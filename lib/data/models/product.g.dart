// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      json['id'] as String?,
      json['name'] as String?,
      json['preview_picture'] as Map<String, dynamic>?,
      json['address'] as String?,
      json['like'] as bool?,
      json['price'] as int?,
      json['date'] as String?,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'preview_picture': instance.image,
      'price': instance.price,
      'address': instance.address,
      'date': instance.date,
      'like': instance.like,
    };
