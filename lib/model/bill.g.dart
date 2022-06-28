// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BillAdapter extends TypeAdapter<Bill> {
  @override
  final int typeId = 5;

  @override
  Bill read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bill(
      customer: fields[1] as Customer,
      id: fields[0] as String?,
      addedAt: fields[3] as DateTime?,
      cashier: fields[2] as String?,
      items: (fields[4] as List).cast<TicketItem>(),
      amountPaid: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Bill obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.customer)
      ..writeByte(2)
      ..write(obj.cashier)
      ..writeByte(3)
      ..write(obj.addedAt)
      ..writeByte(4)
      ..write(obj.items)
      ..writeByte(5)
      ..write(obj.amountPaid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bill _$BillFromJson(Map<String, dynamic> json) => Bill(
      customer: Customer.fromJson(json['customer'] as Map<String, dynamic>),
      id: json['_id'] as String?,
      addedAt: json['addedAt'] == null
          ? null
          : DateTime.parse(json['addedAt'] as String),
      cashier: json['cashier'] as String? ?? 'Owner',
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => TicketItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      amountPaid: json['amountPaid'] as int?,
    );

Map<String, dynamic> _$BillToJson(Bill instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('_id', instance.id);
  val['customer'] = instance.customer;
  writeNotNull('cashier', instance.cashier);
  writeNotNull('addedAt', instance.addedAt?.toIso8601String());
  val['items'] = instance.items;
  writeNotNull('amountPaid', instance.amountPaid);
  return val;
}
