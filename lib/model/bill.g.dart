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
      customer: fields[1] as Customer?,
      id: fields[0] as String?,
      addedAt: fields[3] as DateTime?,
      cashier: fields[2] as String?,
      items: (fields[4] as List).cast<TicketItem>(),
      amountPaid: fields[5] as int?,
      isPaid: fields[6] as bool?,
      email: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Bill obj) {
    writer
      ..writeByte(8)
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
      ..write(obj.amountPaid)
      ..writeByte(6)
      ..write(obj.isPaid)
      ..writeByte(7)
      ..write(obj.email);
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
      customer: json['customer'] == null
          ? null
          : Customer.fromJson(json['customer'] as Map<String, dynamic>),
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
      isPaid: json['isPaid'] as bool? ?? false,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$BillToJson(Bill instance) => <String, dynamic>{
      '_id': instance.id,
      'customer': instance.customer,
      'cashier': instance.cashier,
      'addedAt': instance.addedAt?.toIso8601String(),
      'items': instance.items,
      'amountPaid': instance.amountPaid,
      'isPaid': instance.isPaid,
      'email': instance.email,
    };
