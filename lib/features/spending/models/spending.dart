import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../core/utils/converters/date_time_converter.dart';
part 'spending.g.dart';

@JsonSerializable()
class Spending extends Equatable {
  final String id;
  final int? cost;
  final String? categoryId;
  final String? categoryName;
  final String? otherCategory;
  final String? userEmail;
  final String? note;

  @DateTimeConverter()
  final DateTime? createdDate;

  final String? index;

  const Spending({
    required this.id,
    this.cost,
    this.categoryId,
    this.userEmail,
    this.note,
    this.createdDate,
    this.categoryName,
    this.otherCategory,
    this.index,
  });

  factory Spending.fromJson(Map<String, dynamic> json) =>
      _$SpendingFromJson(json);

  Map<String, dynamic> toJson() => _$SpendingToJson(this);

  @override
  List<Object?> get props => [
        id,
        cost,
        categoryId,
        note,
        index,
      ];
}
