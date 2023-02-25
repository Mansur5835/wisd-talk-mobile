// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
      json['date'] as String?,
      json['id'] as String?,
      (json['rating'] as num?)?.toDouble(),
      json['text'] as String?,
      json['user'] == null
          ? null
          : ReviewUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'rating': instance.rating,
      'date': instance.date,
      'user': instance.user?.toJson(),
    };
