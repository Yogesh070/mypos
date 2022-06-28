// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addon.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddonAdapter extends TypeAdapter<Addon> {
  @override
  final int typeId = 2;

  @override
  Addon read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Addon(
      id: fields[0] as String,
      description: fields[2] as String,
      maxAvailable: fields[4] as int?,
      name: fields[1] as String,
      price: fields[3] as double,
      isSynced: fields[5] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Addon obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.maxAvailable)
      ..writeByte(5)
      ..write(obj.isSynced);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Addon _$AddonFromJson(Map<String, dynamic> json) => Addon(
      id: json['_id'] as String,
      description: json['description'] as String,
      maxAvailable: json['maxAvailable'] as int?,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      isSynced: json['isSynced'] as bool? ?? false,
    );

Map<String, dynamic> _$AddonToJson(Addon instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'maxAvailable': instance.maxAvailable,
      'isSynced': instance.isSynced,
    };
