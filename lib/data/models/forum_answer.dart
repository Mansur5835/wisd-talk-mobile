import 'package:json_annotation/json_annotation.dart';

part 'forum_answer.g.dart';

@JsonSerializable()
class ForumAnswer {
  final String? id;
  final String? text;

  //  "id": "102",
  //                   "text": "asfasfafafasfadasd"

  ForumAnswer(
    this.id,
    this.text,
  );

  factory ForumAnswer.fromJson(Map<String, dynamic> json) =>
      _$ForumAnswerFromJson(json);

  Map<String, dynamic> toJson() => _$ForumAnswerToJson(this);
}
