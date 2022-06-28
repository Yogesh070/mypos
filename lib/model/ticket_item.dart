import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mypos/model/item.dart';
part 'ticket_item.g.dart';

@HiveType(typeId: 100)
@JsonSerializable()
class TicketItem {
  @HiveField(0, defaultValue: 0)
  int quantity;

  @HiveField(1)
  final Item? item;

  TicketItem({this.quantity = 1, required this.item});

  void increment() {
    quantity++;
  }

  factory TicketItem.fromJson(Map<String, dynamic> json) =>
      _$TicketItemFromJson(json);
  Map<String, dynamic> toJson() => _$TicketItemToJson(this);
}
