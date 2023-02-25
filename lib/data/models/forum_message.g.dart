// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forum_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForumMessageModel _$ForumMessageModelFromJson(Map<String, dynamic> json) =>
    ForumMessageModel(
      id: json['id'] as String?,
      my: json['my'] as bool?,
      answer: json['answer'] == null
          ? null
          : ForumAnswer.fromJson(json['answer'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : ForumUser.fromJson(json['user'] as Map<String, dynamic>),
      text: json['text'] as String?,
      date: json['date'] as String?,
      isLoading: json['isLoading'] as bool? ?? false,
    );

Map<String, dynamic> _$ForumMessageModelToJson(ForumMessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'text': instance.text,
      'answer': instance.answer,
      'date': instance.date,
      'my': instance.my,
      'isLoading': instance.isLoading,
    };
