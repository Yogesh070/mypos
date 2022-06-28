import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'item.g.dart';

@HiveType(typeId: 0)
@JsonSerializable(includeIfNull: false)
class Item {
  Item({
    this.isVeg = false,
    this.usesOfferPrice,
    this.addons,
    this.categories = const [],
    this.id,
    required this.name,
    required this.price,
    this.image,
    this.usesStocks = false,
    this.description,
    this.offerPrice,
    this.costPrice,
    this.inStock,
    this.lowStock,
    this.sku,
  });

  @HiveField(0)
  bool? isVeg;

  @HiveField(1)
  bool? usesOfferPrice;

  @HiveField(2)
  List<String>? addons;

  @HiveField(3)
  List<String>? categories;

  @HiveField(4)
  @JsonKey(name: '_id')
  String? id;

  @HiveField(5)
  String name;

  @HiveField(6)
  String? description;

  @HiveField(7)
  dynamic price;

  @HiveField(8)
  String? image;

  @HiveField(9)
  bool? usesStocks;

  @HiveField(10)
  int? offerPrice;

  @HiveField(11)
  String? sku;

  @HiveField(12)
  int? lowStock;

  @HiveField(13)
  int? costPrice;

  @HiveField(14)
  int? inStock;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);

  //****** */ not added *******
  // barcode ?
  //orderedCount

  // factory Item.fromJson(Map<String, dynamic> json) => Item(
  //       isVeg: json["isVeg"],
  //       usesOfferPrice: json["usesOfferPrice"],
  //       addons: List<String>.from(json["addons"].map((x) => x)),
  //       categories: List<String>.from(json["categories"].map((x) => x)),
  //       id: json["_id"],
  //       name: json["name"],
  //       price: json["price"],
  //       offerPrice: json["offerPrice"],
  //       image: json["image"] ??
  //           'https://www.wddonline.com/content/uploads/2020/08/placeholder-image.png',
  //       description: json["description"],
  //       inStock: json["inStock"],
  //       lowStock: json["lowStock"],
  //       usesStocks: json["usesStocks"],
  //       sku: json["sku"],
  //       costPrice: json["costPrice"],
  //       // orderedCount: json["orderedCount"],
  //     );

  // Map<String, dynamic> toJson() {
  //   var toReturn = {
  //     "isVeg": isVeg,
  //     // "addons": List<String>.from(addons!.map((x) => x)),
  //     "categories": List<dynamic>.from(categories!.map((x) => x)),
  //     "_id": id,
  //     "name": name,
  //     "price": price,
  //     // "image": image == null ? null : image,
  //     "description": description ?? '',
  //     "usesStocks": usesStocks ?? false,
  //     // "orderedCount": orderedCount,
  //   };
  //   if (addons != null) {
  //     toReturn["addons"] = List<String>.from(addons!.map((x) => x));
  //   }
  //   if (inStock != null) {
  //     toReturn["inStock"] = inStock;
  //   }
  //   if (lowStock != null) {
  //     toReturn["lowStock"] = lowStock;
  //   }
  //   if (costPrice != null) {
  //     toReturn["costPrice"] = costPrice;
  //   }
  //   if (offerPrice != null) {
  //     toReturn["offerPrice"] = offerPrice;
  //   }
  //   if (sku != null) {
  //     toReturn["sku"] = sku;
  //   }
  //   if (usesOfferPrice == true) {
  //     toReturn["usesOfferPrice"] = usesOfferPrice;
  //   }

  //   return toReturn;
  // }

  @override
  String toString() {
    return '{isVeg:$isVeg, categories:$categories, _id:$id, name:$name, price:$price, description:$description, usesStocks:$usesStocks}';
  }
}
