import 'package:json_annotation/json_annotation.dart';
part 'spending_request.g.dart';

@JsonSerializable()
class SpendingRequest {
  int cost;
  String? categoryId;
  String? categoryName;
  String? note;
  DateTime? createdDate;
  String? otherCategory;
  String? id;

  SpendingRequest({
    required this.cost,
    this.id,
    this.categoryId,
    this.note,
    this.otherCategory,
    this.categoryName,
    this.createdDate,
  });

  factory SpendingRequest.fromJson(Map<String, dynamic> json) =>
      _$SpendingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SpendingRequestToJson(this);
}
