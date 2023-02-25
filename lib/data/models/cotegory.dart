import 'package:json_annotation/json_annotation.dart';

part 'cotegory.g.dart';

@JsonSerializable()
class CotegoryModel {
  @JsonKey(name: "category_id")
  final String? categoryId;
  final String? name;
  final String? icon;

  CotegoryModel(this.categoryId, this.name, this.icon);

  factory CotegoryModel.fromJson(Map<String, dynamic> json) =>
      _$CotegoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CotegoryModelToJson(this);
}
