// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemAdapter extends TypeAdapter<Item> {
  @override
  final int typeId = 0;

  @override
  Item read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Item(
      isVeg: fields[0] as bool?,
      usesOfferPrice: fields[1] as bool?,
      addons: (fields[2] as List?)?.cast<String>(),
      categories: (fields[3] as List?)?.cast<String>(),
      id: fields[4] as String?,
      name: fields[5] as String,
      price: fields[7] as dynamic,
      image: fields[8] as String?,
      usesStocks: fields[9] as bool?,
      description: fields[6] as String?,
      offerPrice: fields[10] as int?,
      costPrice: fields[13] as int?,
      inStock: fields[14] as int?,
      lowStock: fields[12] as int?,
      sku: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Item obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.isVeg)
      ..writeByte(1)
      ..write(obj.usesOfferPrice)
      ..writeByte(2)
      ..write(obj.addons)
      ..writeByte(3)
      ..write(obj.categories)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.price)
      ..writeByte(8)
      ..write(obj.image)
      ..writeByte(9)
      ..write(obj.usesStocks)
      ..writeByte(10)
      ..write(obj.offerPrice)
      ..writeByte(11)
      ..write(obj.sku)
      ..writeByte(12)
      ..write(obj.lowStock)
      ..writeByte(13)
      ..write(obj.costPrice)
      ..writeByte(14)
      ..write(obj.inStock);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      isVeg: json['isVeg'] as bool? ?? false,
      usesOfferPrice: json['usesOfferPrice'] as bool?,
      addons:
          (json['addons'] as List<dynamic>?)?.map((e) => e as String).toList(),
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      id: json['_id'] as String?,
      name: json['name'] as String,
      price: json['price'],
      image: json['image'] as String?,
      usesStocks: json['usesStocks'] as bool? ?? false,
      description: json['description'] as String?,
      offerPrice: json['offerPrice'] as int?,
      costPrice: json['costPrice'] as int?,
      inStock: json['inStock'] as int?,
      lowStock: json['lowStock'] as int?,
      sku: json['sku'] as String?,
    );

Map<String, dynamic> _$ItemToJson(Item instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('isVeg', instance.isVeg);
  writeNotNull('usesOfferPrice', instance.usesOfferPrice);
  writeNotNull('addons', instance.addons);
  writeNotNull('categories', instance.categories);
  writeNotNull('_id', instance.id);
  val['name'] = instance.name;
  writeNotNull('description', instance.description);
  writeNotNull('price', instance.price);
  writeNotNull('image', instance.image);
  writeNotNull('usesStocks', instance.usesStocks);
  writeNotNull('offerPrice', instance.offerPrice);
  writeNotNull('sku', instance.sku);
  writeNotNull('lowStock', instance.lowStock);
  writeNotNull('costPrice', instance.costPrice);
  writeNotNull('inStock', instance.inStock);
  return val;
}
