import 'package:json_annotation/json_annotation.dart';

part 'pagination_counter.g.dart';

@JsonSerializable()
class PaginationCounter {
  @JsonKey(name: "total_count")
  int? totalCount;
  @JsonKey(name: "page_size")
  int? pageSize;
  @JsonKey(name: "current_page")
  int? currentPage;
  @JsonKey(name: "page_count")
  int? pageCount;

  PaginationCounter(
      this.currentPage, this.pageCount, this.pageSize, this.totalCount);

  factory PaginationCounter.fromJson(Map<String, dynamic> json) =>
      _$PaginationCounterFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationCounterToJson(this);
}
