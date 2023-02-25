// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForumModel _$ForumModelFromJson(Map<String, dynamic> json) => ForumModel(
      json['id'] as String?,
      json['name'] as String?,
      json['user_id'] as String?,
      json['user'] as String?,
      json['user_photo'] as String?,
      json['text'] as String?,
      json['date'] as String?,
      json['section_id'] as String?,
      json['detail_text'] as String?,
    );

Map<String, dynamic> _$ForumModelToJson(ForumModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'user_id': instance.userId,
      'user': instance.user,
      'text': instance.text,
      'date': instance.date,
      'user_photo': instance.userPhoto,
      'section_id': instance.sectionId,
      'detail_text': instance.detailText,
    };
