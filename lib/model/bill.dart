import 'package:mypos/model/customer.dart';
import 'package:mypos/model/item.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bill.g.dart';

@HiveType(typeId: 5)
@JsonSerializable(includeIfNull: false)
class Bill {
  @HiveField(0)
  @JsonKey(name: '_id')
  String? id;

  @HiveField(1)
  Customer customer;

  @HiveField(2)
  String? cashier;

  @HiveField(3)
  DateTime? addedAt;

  @HiveField(4)
  List<Item> items;

  Bill({
    required this.customer,
    this.id,
    this.addedAt,
    this.cashier = 'Owner',
    this.items = const [],
  });

  factory Bill.fromJson(Map<String, dynamic> json) => _$BillFromJson(json);
  Map<String, dynamic> toJson() => _$BillToJson(this);
}
