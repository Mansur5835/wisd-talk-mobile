// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewUser _$ReviewUserFromJson(Map<String, dynamic> json) => ReviewUser(
      json['personal_photo'] as String?,
      json['name'] as String?,
      json['last_name'] as String?,
    );

Map<String, dynamic> _$ReviewUserToJson(ReviewUser instance) =>
    <String, dynamic>{
      'name': instance.name,
      'last_name': instance.lastName,
      'personal_photo': instance.personalPhoto,
    };
