// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_menu/models/ModelCommand.dart';

class firebaseCommand {
  addComandToFirebase(
    String name,
    String image,
    double itemPrice,
    double total,
    double friesPrice,
    String fries,
    bool isReady,
    int floor,
    int table,
  ) {
    final docCommand = FirebaseFirestore.instance.collection('commands').doc();
    ModelCommand command = ModelCommand(
        name: name,
        image: image,
        fries: fries,
        friesPrice: friesPrice,
        itemPrice: itemPrice,
        total: total,
        floor: floor,
        table: table,
        isReady: isReady);
    final json = command.toJson();
    docCommand.set(json);
  }

  FirebaseFirestore data = FirebaseFirestore.instance;
  Stream<List<ModelCommand>> getCommand(int floor, int table) {
    return data
        .collection('commands')
        .where('floor', isEqualTo: floor)
        .where('table', isEqualTo: table)
        .snapshots()
        .map(
          (snaps) => snaps.docs
              .map((e) => ModelCommand.fromJson(
                    e.data(),
                  ))
              .toList(),
        );
  }

  Future<double> gettotal(int floor, int table) {
    return data
        .collection('commands')
        .where('floor', isEqualTo: floor)
        .where('table', isEqualTo: table)
        .limit(1)
        .get()
        .then((value) => value.docs[0].data()['total']);
  }

  addFloorTable(int floor, int table) {
    final doc = data.collection('table').doc('${floor} ${table}');
    final json = {'floor': floor, 'table': table};
    doc.set(json);
  }

  Stream<QuerySnapshot> gettable() {
    return data.collection('table').snapshots();
  }

  commanReady(int floor, int table) async {
    var collection = data
        .collection('commands')
        .where('floor', isEqualTo: floor)
        .where('table', isEqualTo: table);
    var querySnapshots = await collection.get();
    for (var doc in querySnapshots.docs) {
      await doc.reference.update({
        'isReady': true,
      });
    }
  }

  commandDelete(int floor, int table) async {
    var collection = data
        .collection('commands')
        .where('floor', isEqualTo: floor)
        .where('table', isEqualTo: table);
    var querySnapshots = await collection.get();
    for (var doc in querySnapshots.docs) {
      await doc.reference.delete();
    }
  }

  tableDelete(int floor, int table) async {
    var collection = data
        .collection('table')
        .where('floor', isEqualTo: floor)
        .where('table', isEqualTo: table);
    var querySnapshots = await collection.get();

    for (var doc in querySnapshots.docs) {
      doc.reference.delete();
    }
  }
}
