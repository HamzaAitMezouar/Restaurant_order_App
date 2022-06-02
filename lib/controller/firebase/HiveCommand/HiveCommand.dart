import 'package:hive/hive.dart';
part 'HiveCommand.g.dart';

@HiveType(typeId: 0)
class CommandHive extends HiveObject {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String image;
  @HiveField(2)
  late double itemPrice;
  @HiveField(3)
  late double total;
  @HiveField(4)
  late double friesPrice;
  @HiveField(5)
  late String fries;
  @HiveField(6)
  late bool isReady;
  /* @HiveField(7)
  late int? floor;
  @HiveField(8)
  late int table;*/
  /* CommandHive(
      {required this.name,
      required this.image,
      required this.fries,
      required this.friesPrice,
      required this.itemPrice,
      required this.total,
      this.isReady});*/
}
