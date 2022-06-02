import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_menu/controller/firebase/FirebaseCommand.dart';
import 'package:restaurant_menu/controller/firebase/HiveCommand/HiveCommand.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:restaurant_menu/controller/provider/FloorTableProvider.dart';
import 'package:restaurant_menu/models/ModelCommand.dart';
import '../../controller/firebase/HiveCommand/Boxes.dart';
import 'dart:ui' as ui;

class TabletCommand extends StatefulWidget {
  const TabletCommand({Key? key}) : super(key: key);

  @override
  State<TabletCommand> createState() => _TabletCommandState();
}

class _TabletCommandState extends State<TabletCommand> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
      stream: firebaseCommand().gettable(),
      builder: (context, snapshots) {
        if (!snapshots.hasData) {
          print('Nodaatata2');
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        } else {
          final command = snapshots.data;
          for (int j = 0; j < command!.size; j++) {
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.center,
                  height: size.height * 0.2,
                  child: Text(
                    'This Order is For Table ${snapshots.data!.docs[j]['table']} in floor ${snapshots.data!.docs[j]['floor']}',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        foreground: Paint()
                          ..shader = ui.Gradient.linear(
                            const Offset(0, 20),
                            const Offset(150, 20),
                            <Color>[
                              Color.fromARGB(255, 255, 166, 0),
                              Color.fromARGB(255, 255, 145, 0),
                            ],
                          )),
                  ),
                ),
                StreamBuilder<List<ModelCommand>>(
                  stream: firebaseCommand().getCommand(
                      command.docs[j]['floor'], command.docs[j]['table']),
                  builder: (context, snaps) {
                    if (!snaps.hasData) {
                      print('Nodaatata');
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snaps.hasData) {
                      List<ModelCommand> command = snaps.data!;
                      print(command.length);
                      return Container(
                        height: size.height * 0.8,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.zero,
                              height: size.height * 0.2,
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: command.length,
                                  itemBuilder: (context, i) {
                                    print(command.length);

                                    return Card(
                                      child: ListTile(
                                        leading: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Container(
                                            width: size.width * 0.2,
                                            child:
                                                Image.network(command[i].image),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          command[i].name,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        trailing: Text(
                                            '\$${command[i].itemPrice}',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.amber)),
                                      ),
                                    );
                                  }),
                            ),
                            command[j].friesPrice == 0
                                ? Container()
                                : Container(
                                    height: size.height * 0.1,
                                    child: Row(children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Container(
                                          width: size.width * 0.2,
                                          child:
                                              Image.asset('assets/fries.png'),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.1,
                                      ),
                                      Text(
                                        command[j].fries,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.60,
                                      ),
                                      Text('\$${command[j].friesPrice}',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.amber))
                                    ]),
                                  ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Total : ',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromARGB(255, 0, 0, 0))),
                                  Text('\$${command[j].total}',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.amber)),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  elevation: 10,
                                  padding: EdgeInsets.zero,
                                  primary:
                                      const Color.fromARGB(255, 233, 200, 11)),
                              child: Container(
                                  alignment: Alignment.center,
                                  height: size.height * 0.04,
                                  width: size.width * 0.3,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 233, 92, 11),
                                        Color.fromARGB(255, 248, 228, 44)
                                      ],
                                    ),
                                  ),
                                  child: const Text('Ready !')),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            );
          }
          return Container();
        }
      },
    ));
  }
}
/*ValueListenableBuilder<Box<CommandHive>>(
      valueListenable: Boxes.getCommand().listenable(),
      builder: (context, box, _) {
        print('box.values.toList().cast<CommandHive>()');
        print(box.values.toList().cast<CommandHive>());
        final command = box.values.toList().cast<CommandHive>();
        return ListView.builder(
            itemCount: command.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(command[index].image),
                ),
                title: Text(command[index].name),
              );
            });
      },
    )*/