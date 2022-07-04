import 'package:mypos/model/customer.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mypos/model/ticket_item.dart';

part 'bill.g.dart';

@HiveType(typeId: 5)
// @JsonSerializable(includeIfNull: false)
@JsonSerializable()
class Bill {
  @HiveField(0)
  @JsonKey(name: '_id')
  String? id;

  @HiveField(1)
  Customer? customer;

  @HiveField(2)
  String? cashier;

  @HiveField(3)
  DateTime? addedAt;

  @HiveField(4)
  List<TicketItem> items;

  @HiveField(5)
  int? amountPaid;

  @HiveField(6)
  bool? isPaid;

  @HiveField(7)
  String? email;

  Bill(
      {this.customer,
      this.id,
      this.addedAt,
      this.cashier = 'Owner',
      this.items = const [],
      this.amountPaid,
      this.isPaid = false,
      this.email});

  factory Bill.fromJson(Map<String, dynamic> json) => _$BillFromJson(json);
  Map<String, dynamic> toJson() => _$BillToJson(this);
}
