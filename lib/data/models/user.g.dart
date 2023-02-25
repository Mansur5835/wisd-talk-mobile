// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['gender'] as String?,
      json['email'] as String?,
      json['name'] as String?,
      json['phone'] as String?,
      json['photo'] as String?,
      json['city'] as String?,
      json['birthday'] as String?,
      json['about_me'] as String?,
      json['login'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'login': instance.login,
      'name': instance.name,
      'gender': instance.gender,
      'phone': instance.phone,
      'photo': instance.photo,
      'birthday': instance.birthday,
      'about_me': instance.aboutMe,
      'city': instance.city,
    };
