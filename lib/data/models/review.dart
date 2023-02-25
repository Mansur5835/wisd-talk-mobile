import 'package:json_annotation/json_annotation.dart';
import 'package:withtalk_mobile/data/models/review_user.dart';
import 'package:withtalk_mobile/data/models/user.dart';

part 'review.g.dart';

@JsonSerializable(explicitToJson: true)
class ReviewModel {
  final String? id;
  final String? text;
  final double? rating;
  final String? date;
  final ReviewUser? user;

  ReviewModel(this.date, this.id, this.rating, this.text, this.user);

  factory ReviewModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}
