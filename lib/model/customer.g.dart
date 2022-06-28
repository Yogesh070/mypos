// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomerAdapter extends TypeAdapter<Customer> {
  @override
  final int typeId = 3;

  @override
  Customer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Customer(
      id: fields[0] as String?,
      name: fields[1] as String,
      email: fields[2] as String?,
      phone: fields[3] as String?,
    )
      ..addedBy = fields[4] as String?
      ..business = fields[5] as String?
      ..v = fields[6] as int?
      ..deletedBy = fields[7] as String?;
  }

  @override
  void write(BinaryWriter writer, Customer obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.addedBy)
      ..writeByte(5)
      ..write(obj.business)
      ..writeByte(6)
      ..write(obj.v)
      ..writeByte(7)
      ..write(obj.deletedBy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      id: json['_id'] as String?,
      name: json['name'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
    )
      ..addedBy = json['addedBy'] as String?
      ..business = json['business'] as String?
      ..v = json['__v'] as int?
      ..deletedBy = json['deletedBy'] as String?;

Map<String, dynamic> _$CustomerToJson(Customer instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('_id', instance.id);
  val['name'] = instance.name;
  writeNotNull('email', instance.email);
  writeNotNull('phone', instance.phone);
  writeNotNull('addedBy', instance.addedBy);
  writeNotNull('business', instance.business);
  writeNotNull('__v', instance.v);
  writeNotNull('deletedBy', instance.deletedBy);
  return val;
}
