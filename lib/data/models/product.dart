import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class ProductModel {
  final String? id;
  final String? name;
  @JsonKey(name: "preview_picture")
  final Map? image;
  final int? price;
  final String? address;
  final String? date;
  final bool? like;
  //  {
  //           "id": "3",
  //           "name": "Mehmonxona mebel",
  //           "picture": "/upload/iblock/63d/dxo6jyfs3yk3bvw8ezyry17st18i55ta.jpg",
  //           "price": "150 000",
  //           "sold": 0,
  //           "rating": 0
  //       }

  ProductModel(this.id, this.name, this.image, this.address, this.like,
      this.price, this.date);

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
