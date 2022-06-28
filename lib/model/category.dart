import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@HiveType(typeId: 1)
@JsonSerializable(includeIfNull: false)
class Category {
  Category({this.id, required this.name, required this.color});

  @HiveField(0)
  @JsonKey(name: '_id')
  String? id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String color;

  @HiveField(3)
  String? addedBy;

  @HiveField(4)
  String? business;

  @HiveField(5)
  @JsonKey(name: '__v')
  int? v;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
