// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TicketItemAdapter extends TypeAdapter<TicketItem> {
  @override
  final int typeId = 100;

  @override
  TicketItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TicketItem(
      quantity: fields[0] == null ? 0 : fields[0] as int,
      item: fields[1] as Item?,
    );
  }

  @override
  void write(BinaryWriter writer, TicketItem obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.quantity)
      ..writeByte(1)
      ..write(obj.item);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TicketItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketItem _$TicketItemFromJson(Map<String, dynamic> json) => TicketItem(
      quantity: json['quantity'] as int? ?? 1,
      item: json['item'] == null
          ? null
          : Item.fromJson(json['item'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TicketItemToJson(TicketItem instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'item': instance.item,
    };
