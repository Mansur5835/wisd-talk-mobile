import 'package:json_annotation/json_annotation.dart';

part 'furniture_detail.g.dart';

@JsonSerializable()
class FurnitureDetailModel {
  @JsonKey(name: "preview_text")
  final String? previewText;
  final String? name;
  final List<String>? image;
  final List<String>? video;
  final int? sold;
  final String? shop;
  final double? rating;
  @JsonKey(name: "review_count")
  final double? reviewCount;
  final bool? fav;
  @JsonKey(name: "name_model")
  final String? nameModel;
  final String? production;
  final String? model;
  final String? color;
  final String? style;
  final String? meshanism;
  final String? installment;
  final String? material;
  final String? price;
  final String? phone;
// "name": "Yotoqxona uchun ",
//    "preview_text": "Yotoqxona uchun ",
//    "picture": "/upload/iblock/63d/dxo6jyfs3yk3bvw8ezyry17st18i55ta.jpg",
//    "sold": 0,
//    "rating": 0,
//    "review_count": 0,
//    "fav": true,
//    "name_model": "",
//  "image": [
//         "/upload/iblock/1f7/48xs0balzrislbxlxtdqri3jsdmm5kzb.jpeg",
//         "/upload/iblock/e60/27vg3w3qene75v35xcc2fvmdpcrpqkbp.jpeg"
//     ],
//     "video": [
//         "/upload/iblock/e4f/k6anz3dl215ocfex6a6l9y266szdwwml.mp4",
//         "/upload/iblock/54d/kiekieh2mebb0libqkqftpko6dj2gio2.mp4"
//     ],
//    "production": "",
//    "material": "paxta",
//    "subcategory": "",
//    "price": "250 000",
//    "phone": "998151588"

  FurnitureDetailModel(
      this.material,
      this.color,
      this.installment,
      this.meshanism,
      this.model,
      this.style,
      this.name,
      this.shop,
      this.image,
      this.video,
      this.rating,
      this.sold,
      this.fav,
      this.nameModel,
      this.phone,
      this.previewText,
      this.price,
      this.production,
      this.reviewCount);

  factory FurnitureDetailModel.fromJson(Map<String, dynamic> json) =>
      _$FurnitureDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$FurnitureDetailModelToJson(this);
}
