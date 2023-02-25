import 'package:json_annotation/json_annotation.dart';
import 'package:withtalk_mobile/data/models/forum_answer.dart';
import 'package:withtalk_mobile/data/models/forum_user.dart';

part 'forum_message.g.dart';

@JsonSerializable()
class ForumMessageModel {
  final String? id;
  final ForumUser? user;
  final String? text;
  final ForumAnswer? answer;
  final String? date;
  final bool? my;
  bool isLoading;

  // {
  //               "id": "104",
  //               "text": "asfasfafafasfadasd",
  //               "user": {
  //                   "name": "wqd",
  //                   "last_name": "qwdqwd",
  //                   "personal_photo": "/upload/resize_cache/iblock/0c4/500_500_0/581wir6bb9niu80go2mna5caaa0gs418.png"
  //               },
  //               "date": "09.02.2023 22:35:08",
  //               "answer": {
  //                   "id": "102",
  //                   "text": "asfasfafafasfadasd"
  //               }

  ForumMessageModel(
      {this.id,
      this.my,
      this.answer,
      this.user,
      this.text,
      this.date,
      this.isLoading = false});

  factory ForumMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ForumMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForumMessageModelToJson(this);
}
