import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'addon.g.dart';

//  "name": "cheese",
//   "price": 50,
//   "description": "This is a cheese for maybe burgers and pizzas",
//   "maxAvailable": 3

@HiveType(typeId: 2)
@JsonSerializable()
class Addon {
  @HiveField(0)
  @JsonKey(name: '_id')
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String description;

  @HiveField(3)
  double price;

  @HiveField(4)
  int? maxAvailable;

  @HiveField(5)
  bool? isSynced;

  Addon({
    required this.id,
    required this.description,
    this.maxAvailable,
    required this.name,
    required this.price,
    this.isSynced = false,
  });

  factory Addon.fromJson(Map<String, dynamic> json) => _$AddonFromJson(json);
  Map<String, dynamic> toJson() => _$AddonToJson(this);

  // Addon copyWith(
  //         {String? id,
  //         String? name,
  //         String? description,
  //         double? price,
  //         int? maxAvailable,
  //         bool? isSynced}) =>
  //     Addon(
  //       id: id ?? this.id,
  //       name: name ?? this.name,
  //       description: description ?? this.description,
  //       price: price ?? this.price,
  //       maxAvailable: maxAvailable ?? this.maxAvailable,
  //       isSynced: isSynced ?? this.isSynced,
  //     );
}
