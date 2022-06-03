import 'package:flutter/cupertino.dart';
import 'package:restaurant_menu/models/items.dart';

class CommandProvider extends ChangeNotifier {
  int counter = 0;
  double total = 0;
  double friesPrice = 0;
  String fries = '';
  String friesyes = 'Fries';
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
    counter = 0;
    total = 0;
    friesPrice = 0;
    notifyListeners();
  }

  addtotalprice(double itemPrice) {
    total = total + itemPrice + friesPrice;
    notifyListeners();
  }

  deletetotalprice(double itemPrice) {
    total = total - itemPrice;
    notifyListeners();
  }

  resettotale() {
    total = 0;
    notifyListeners();
  }

  addfriesPrice() {
    friesPrice = 5;
    notifyListeners();
  }

  removefriesPrice() {
    friesPrice = 0;
    notifyListeners();
  }

  friesYes() {
    friesyes = 'Fries';
    notifyListeners();
  }

  FriesNo() {
    fries = '';
    notifyListeners();
  }
}
