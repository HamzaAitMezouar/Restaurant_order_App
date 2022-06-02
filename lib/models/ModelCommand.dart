import 'package:json_annotation/json_annotation.dart';

part 'ModelCommand.g.dart';

@JsonSerializable()
class ModelCommand {
  String name;

  String image;

  double itemPrice;

  double total;

  double friesPrice;

  String fries;

  bool? isReady = false;

  int? floor;

  int? table;
  ModelCommand(
      {required this.name,
      required this.image,
      required this.fries,
      required this.friesPrice,
      required this.itemPrice,
      required this.total,
      required this.floor,
      required this.table,
      this.isReady});
  factory ModelCommand.fromJson(Map<String, dynamic> json) =>
      _$ModelCommandFromJson(json);

  Map<String, dynamic> toJson() => _$ModelCommandToJson(this);
  @override
  String toString() {
    // TODO: implement toString
    return 'Item{name: $name, image: $image,itemPrice: $itemPrice,total: $total,friesPrice:$friesPrice ,fries:$fries ,isReady:$isReady,floor:$floor ,table :$table}';
  }
}
