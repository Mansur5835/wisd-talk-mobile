// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forum_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForumUser _$ForumUserFromJson(Map<String, dynamic> json) => ForumUser(
      json['last_name'] as String?,
      json['name'] as String?,
      json['personal_photo'] as String?,
    );

Map<String, dynamic> _$ForumUserToJson(ForumUser instance) => <String, dynamic>{
      'name': instance.name,
      'last_name': instance.lastName,
      'personal_photo': instance.userPhoto,
    };
