import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'business.g.dart';

@HiveType(typeId: 4)
@JsonSerializable()
class Business {
  @HiveField(0)
  @JsonKey(name: '_id')
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String? color;

  @HiveField(3)
  @JsonKey(name: 'pan_no')
  int? panNo;

  @HiveField(4)
  String? owner;

  @HiveField(5)
  DateTime? createdAt;

  @HiveField(6)
  DateTime? updatedAt;

  @HiveField(7)
  @JsonKey(name: '__v')
  int? v;

  @HiveField(8)
  @JsonKey(name: 'id')
  String? businessId;
  Business({
    required this.id,
    required this.name,
    this.color,
    this.owner,
    this.panNo,
  });
  factory Business.fromJson(Map<String, dynamic> json) =>
      _$BusinessFromJson(json);
  Map<String, dynamic> toJson() => _$BusinessToJson(this);
}
