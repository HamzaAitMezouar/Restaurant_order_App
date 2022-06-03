// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_menu/controller/firebase/FirebaseCommand.dart';
import 'package:restaurant_menu/controller/firebase/HiveCommand/HiveCommand.dart';
import 'package:restaurant_menu/controller/provider/CommandProvider.dart';
import 'package:restaurant_menu/models/items.dart';
import 'dart:ui' as ui;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:restaurant_menu/pages/TablesPage.dart';
import 'package:restaurant_menu/pages/Tablet/TabletCommand.dart';
import 'package:restaurant_menu/utils/routeAnimation.dart';
import '../controller/firebase/HiveCommand/Boxes.dart';
import '../controller/provider/FloorTableProvider.dart';

class Command extends StatefulWidget {
  int floor;
  int table;
  Command({Key? key, required this.floor, required this.table})
      : super(key: key);

  @override
  State<Command> createState() => CommandState(
        floor: floor,
        table: table,
      );
}

class CommandState extends State<Command> {
  int floor;
  int table;
  CommandState({required this.floor, required this.table});
  @override
  void dispose() {
    //Hive.close();
    super.dispose();
  }

  /*Future addCommandToHive(
      String name,
      String image,
      double itemPrice,
      double total,
      double friesPrice,
      String fries,
      bool? isReady,
      int table,
      int floor) async {
    final command = CommandHive()
      ..name = name
      ..fries = fries
      ..image = image
      ..friesPrice = friesPrice
      ..total = total
      ..itemPrice = itemPrice
      //..floor = floor
      // ..table = table
      ..isReady = false;
    final box = Boxes.getCommand();
    box.add(command);
  }*/

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final command = Provider.of<CommandProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15),
            height: size.height * 0.2,
            child: Lottie.asset('assets/time.json'),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Center(
              child: Text(
            'Table ${table} in Floor Number ${floor}',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                foreground: Paint()
                  ..shader = ui.Gradient.linear(
                    const Offset(0, 20),
                    const Offset(150, 20),
                    <Color>[
                      Color.fromARGB(255, 238, 0, 0),
                      Color.fromARGB(255, 255, 145, 0),
                    ],
                  )),
          )),
          Container(
            height: size.height * 0.3,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: command.commandItems.length,
              itemBuilder: (BuildContext context, int index) {
                List<Item> items = command.commandItems;
                return Card(
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: size.width * 0.2,
                        child: Image.network(items[index].image),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    title: Text(
                      items[index].name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    trailing: Text('\$${items[index].price}',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.amber)),
                  ),
                );
              },
            ),
          ),
          command.friesPrice == 0
              ? Container()
              : Container(
                  height: size.height * 0.1,
                  child: Row(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: size.width * 0.2,
                        child: Image.asset('assets/fries.png'),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.1,
                    ),
                    Text(
                      command.friesyes,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: size.width * 0.45,
                    ),
                    Text('\$${command.friesPrice}',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.amber))
                  ]),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('\$${command.total}',
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.amber)),
              SizedBox(
                width: size.width * 0.05,
              )
            ],
          ),
          Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 10,
                    primary: Color.fromARGB(255, 9, 240, 163).withOpacity(0.8)),
                onPressed: () {
                  Navigator.pushReplacement(
                      context, pageRoute(child: const TablesPage()));
                  for (int i = 0; i < command.commandItems.length; i++) {
                    firebaseCommand().addComandToFirebase(
                        command.commandItems[i].name,
                        command.commandItems[i].image,
                        command.commandItems[i].price,
                        command.total,
                        command.friesPrice,
                        command.friesPrice == 0
                            ? command.fries
                            : command.friesyes,
                        false,
                        floor,
                        table);
                  }
                  firebaseCommand().addFloorTable(floor, table);
                  command.disposelist();
                },
                child: const Text('Send')),
          )
        ],
      ),
    );
  }
}
