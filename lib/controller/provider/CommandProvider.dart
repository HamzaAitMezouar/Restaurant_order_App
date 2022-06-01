import 'package:flutter/cupertino.dart';
import 'package:restaurant_menu/models/items.dart';

class CommandProvider extends ChangeNotifier {
  int counter = 0;
  double total = 0;
  List<Item> commandItems = [];
  double get totalprice => total;

  addItem(Item item) {
    commandItems.add(item);
    counter++;
    notifyListeners();
    print(commandItems.length);
  }

  removeItem(Item item) {
    commandItems.remove(item);
    counter--;
    notifyListeners();
  }

  disposelist() {
    commandItems.clear();
    notifyListeners();
  }
}
