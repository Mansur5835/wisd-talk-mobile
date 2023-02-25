import 'package:json_annotation/json_annotation.dart';

part 'forum.g.dart';

@JsonSerializable()
class ForumModel {
  final String? id;
  final String? name;
  @JsonKey(name: "user_id")
  final String? userId;
  final String? user;
  final String? text;
  final String? date;
  @JsonKey(name: "user_photo")
  final String? userPhoto;
  @JsonKey(name: "section_id")
  final String? sectionId;
  @JsonKey(name: "detail_text")
  final String? detailText;
  //  {
  //             "id": "69",
  //             "name": "Увеличение веса во время беременности",
  //             "date": "2023.02.08",
  //             "text": "qwdqwdqwdqwd",
  //             "user_id": "2",
  //             "user": "wqd qwdqwd",
  //             "user_photo": "/upload/iblock/0c4/581wir6bb9niu80go2mna5caaa0gs418.png"
  //         },

  ForumModel(this.id, this.name, this.userId, this.user, this.userPhoto,
      this.text, this.date, this.sectionId, this.detailText);

  factory ForumModel.fromJson(Map<String, dynamic> json) =>
      _$ForumModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForumModelToJson(this);
}
