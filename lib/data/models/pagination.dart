import 'package:json_annotation/json_annotation.dart';
import 'package:withtalk_mobile/data/models/pagination_counter.dart';

part 'pagination.g.dart';

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class Pagination<T> {
  final List<T>? info;
  final PaginationCounter? pagination;

  Pagination(this.info, this.pagination);

  factory Pagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$PaginationFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$PaginationToJson(this, toJsonT);
}
