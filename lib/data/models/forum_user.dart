import 'package:json_annotation/json_annotation.dart';

part 'forum_user.g.dart';

@JsonSerializable()
class ForumUser {
  final String? name;
  @JsonKey(name: "last_name")
  final String? lastName;
  @JsonKey(name: "personal_photo")
  final String? userPhoto;
  // "user": {
  // //                   "name": "wqd",
  // //                   "last_name": "qwdqwd",
  // //                   "personal_photo": "/upload/resize_cache/iblock/0c4/500_500_0/581wir6bb9niu80go2mna5caaa0gs418.png"
  // //               },

  ForumUser(
    this.lastName,
    this.name,
    this.userPhoto,
  );

  factory ForumUser.fromJson(Map<String, dynamic> json) =>
      _$ForumUserFromJson(json);

  Map<String, dynamic> toJson() => _$ForumUserToJson(this);
}
