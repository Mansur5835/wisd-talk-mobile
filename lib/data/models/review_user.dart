import 'package:json_annotation/json_annotation.dart';

part 'review_user.g.dart';

@JsonSerializable()
class ReviewUser {
  final String? name;
  @JsonKey(name: "last_name")
  final String? lastName;
  @JsonKey(name: "personal_photo")
  final String? personalPhoto;

  //  "login": "shaxobqwdqw",
  //       "name": "",
  //       "last_name": "",
  //       "email": "asdasd@gmail.comdd",
  //       "gender": "",
  //       "phone": "",
  //       "photo": null,
  //       "city": "",
  //       "about_me": "",
  //       "birthday": nullp
  ReviewUser(this.personalPhoto, this.name, this.lastName);

  factory ReviewUser.fromJson(Map<String, dynamic> json) =>
      _$ReviewUserFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewUserToJson(this);
}
