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
  // Created date format to yyyyMM
  final String? index;
  // Created date format to yyyyMMdd
  final String? indexFull;

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
    this.indexFull,
  });

  factory Spending.fromJson(Map<String, dynamic> json) =>
      _$SpendingFromJson(json);

  Map<String, dynamic> toJson() => _$SpendingToJson(this);

  Spending copyWith({
    String? index,
    String? indexFull,
  }) {
    return Spending(
      id: id,
      cost: cost ?? this.cost,
      categoryId: categoryId ?? this.categoryId,
      userEmail: userEmail ?? this.userEmail,
      note: note ?? this.note,
      createdDate: createdDate ?? this.createdDate,
      categoryName: categoryName ?? this.categoryName,
      otherCategory: otherCategory ?? this.otherCategory,
      index: index ?? this.index,
      indexFull: indexFull ?? this.indexFull,
    );
  }

  @override
  List<Object?> get props => [
        id,
        cost,
        categoryId,
        note,
        index,
      ];
}
