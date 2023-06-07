import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'spending.g.dart';

@JsonSerializable()
class Spending extends Equatable {
  final String id;
  final int? cost;
  final String? categoryId;
  final String? userEmail;
  final String? note;

  Spending(this.id, this.cost, this.categoryId, this.userEmail, this.note);

  factory Spending.fromJson(Map<String, dynamic> json) =>
      _$SpendingFromJson(json);

  Map<String, dynamic> toJson() => _$SpendingToJson(this);

  @override
  List<Object?> get props => [id];
}
