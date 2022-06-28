// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BusinessAdapter extends TypeAdapter<Business> {
  @override
  final int typeId = 4;

  @override
  Business read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Business(
      id: fields[0] as String,
      name: fields[1] as String,
      color: fields[2] as String?,
      owner: fields[4] as String?,
      panNo: fields[3] as int?,
    )
      ..createdAt = fields[5] as DateTime?
      ..updatedAt = fields[6] as DateTime?
      ..v = fields[7] as int?
      ..businessId = fields[8] as String?;
  }

  @override
  void write(BinaryWriter writer, Business obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.color)
      ..writeByte(3)
      ..write(obj.panNo)
      ..writeByte(4)
      ..write(obj.owner)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updatedAt)
      ..writeByte(7)
      ..write(obj.v)
      ..writeByte(8)
      ..write(obj.businessId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusinessAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Business _$BusinessFromJson(Map<String, dynamic> json) => Business(
      id: json['_id'] as String,
      name: json['name'] as String,
      color: json['color'] as String?,
      owner: json['owner'] as String?,
      panNo: json['pan_no'] as int?,
    )
      ..createdAt = json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String)
      ..updatedAt = json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String)
      ..v = json['__v'] as int?
      ..businessId = json['id'] as String?;

Map<String, dynamic> _$BusinessToJson(Business instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'pan_no': instance.panNo,
      'owner': instance.owner,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
      'id': instance.businessId,
    };
