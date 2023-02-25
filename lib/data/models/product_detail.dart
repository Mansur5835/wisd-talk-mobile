import 'package:json_annotation/json_annotation.dart';

part 'product_detail.g.dart';

@JsonSerializable()
class ProductDetailModel {
  final String? id;
  final String? name;
  @JsonKey(name: "detail_text")
  final String? detailText;
  final String? price;
  final String? address;
  final String? phone;
  final double? reting;
  final String? date;
  final bool? like;
  @JsonKey(name: "more_photo")
  final List? morePhotos;
  @JsonKey(name: "user_id")
  final String? userId;
  @JsonKey(name: "user")
  final String? userName;
  @JsonKey(name: "user_photo")
  final String? userPhoto;
  final String? count;
  @JsonKey(name: "parent_section_id")
  final String? parentSectionId;
  @JsonKey(name: "section_id")
  final String? sectionId;

  //       "phone": "+998937969191",
  //       "address": "",
  //       "count": null,
  //       "reting": 5,
  //  "section_id": "5",
  //         "parent_section_id": "3",
  //       "like": false,
  //       "user_id": "2",
  //       "user": "shaxob ",
  //       "user_photo": "/upload/main/4ac/uh2vwpa1sryt6nz5s114zmvmtzxipzei.jpg"

  ProductDetailModel(
      this.id,
      this.name,
      this.phone,
      this.address,
      this.like,
      this.price,
      this.date,
      this.morePhotos,
      this.detailText,
      this.reting,
      this.userId,
      this.userName,
      this.count,
      this.userPhoto,
      this.parentSectionId,
      this.sectionId);

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailModelToJson(this);
}
