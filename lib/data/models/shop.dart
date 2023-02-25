import 'package:json_annotation/json_annotation.dart';

part 'shop.g.dart';

@JsonSerializable(explicitToJson: true)
class ShopModel {
  final String? name;
  @JsonKey(name: "preview_text")
  final String? previewText;
  @JsonKey(name: "picture")
  final List<String>? picture;
  final String? phone;
  final String? address;
  final String? lat;
  final String? lon;
  final double? rating;

  ShopModel(this.name, this.phone, this.picture, this.previewText, this.address,
      this.lat, this.lon, this.rating);

  factory ShopModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ShopModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShopModelToJson(this);
}
