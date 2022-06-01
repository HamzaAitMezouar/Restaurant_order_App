import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_menu/models/items.dart';

//Rapid Api Request Ends
class itemController {
  /* Future<List<Item>> getApi() async {
    final uri = Uri.https('tasty.p.rapidapi.com', '/recipes/list',
        {'from': '0', 'size': '20', 'tags': 'under_30_minutes'});
    final respone = await http.get(uri, headers: {
      'X-RapidAPI-Host': 'tasty.p.rapidapi.com',
      'X-RapidAPI-Key': '0c6056fb09msheeedae083b5a9a9p19681ejsnf6712a42864a'
    });
    Map data = jsonDecode(respone.body);
    List items = [];
    List<Item> itemsList;
    print(data);
    for (var i in data['results']) {
      items.add(i);
    }
    itemsList = items.map((e) => Item.fromJson(e)).toList();
    print(itemsList.length);
    return itemsList;
  }*/
  FirebaseFirestore data = FirebaseFirestore.instance;
  Stream<List<Item>> getItemsByType(String type) {
    return data
        .collection('items')
        .where('type', isEqualTo: type)
        .snapshots()
        .map(
          (snap) => snap.docs
              .map(
                (doc) => Item.fromJson(
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  Stream<QuerySnapshot> getTypes() {
    return data.collection('types').snapshots();
  }
}
