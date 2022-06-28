import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

@HiveType(typeId: 3)
@JsonSerializable(includeIfNull: false)
class Customer {
  Customer({this.id, required this.name, this.email, this.phone});

  @HiveField(0)
  @JsonKey(name: '_id')
  String? id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String? email;

  @HiveField(3)
  String? phone;

  @HiveField(4)
  String? addedBy;

  @HiveField(5)
  String? business;

  @HiveField(6)
  @JsonKey(name: '__v')
  int? v;

  @HiveField(7)
  String? deletedBy;

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}
