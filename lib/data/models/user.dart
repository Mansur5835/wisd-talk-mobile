import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String? email;
  final String? login;
  final String? name;
  final String? gender;
  final String? phone;
  final String? photo;
  final String? birthday;
  @JsonKey(name: "about_me")
  final String? aboutMe;
  final String? city;

  //  "login": "shaxobqwdqw",
  //       "name": "",
  //       "last_name": "",
  //       "email": "asdasd@gmail.comdd",
  //       "gender": "",
  //       "phone": "",
  //       "photo": null,
  //       "city": "",
  //       "about_me": "",
  //       "birthday": null

  User(this.gender, this.email, this.name, this.phone, this.photo, this.city,
      this.birthday, this.aboutMe, this.login);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
