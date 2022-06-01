// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'items.g.dart';

@JsonSerializable()
class Item {
  String name;
  String image;
  String type;
  double price;
  bool isSelected;

  Item(
      {required this.name,
      required this.image,
      required this.price,
      required this.type,
      this.isSelected = true});
  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
  @override
  String toString() {
    // TODO: implement toString
    return 'Item{name: $name, image: $image,price: $price,type: $type,}';
  }
}
