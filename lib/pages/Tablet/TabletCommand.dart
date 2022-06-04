// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import 'package:restaurant_menu/controller/firebase/FirebaseCommand.dart';
import 'package:restaurant_menu/controller/firebase/waiterAuth.dart';

import 'package:restaurant_menu/models/ModelCommand.dart';

import 'dart:ui' as ui;

import 'package:restaurant_menu/pages/Tablet/TabletSignIn.dart';
import 'package:restaurant_menu/utils/routeAnimation.dart';

class TabletCommand extends StatefulWidget {
  const TabletCommand({Key? key}) : super(key: key);

  @override
  State<TabletCommand> createState() => _TabletCommandState();
}

class _TabletCommandState extends State<TabletCommand> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool load = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ;

    return Scaffold(
        appBar: AppBar(
          title: Text('Orders'),
          backgroundColor: Colors.amber[700],
          actions: [
            PopupMenuButton(itemBuilder: (context) {
              return [
                PopupMenuItem(
                    child: Row(
                  children: [
                    Icon(
                      Icons.help,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    SizedBox(
                      width: size.width * 0.04,
                    ),
                    const Text(
                      'Help',
                      style: const TextStyle(fontSize: 20),
                    )
                  ],
                )),
                PopupMenuItem(
                    child: Row(
                  children: [
                    Icon(
                      Icons.dark_mode,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    SizedBox(
                      width: size.width * 0.04,
                    ),
                    const Switch(value: false, onChanged: null)
                  ],
                )),
                PopupMenuItem(
                    child: Container(
                  child: TextButton(
                      onPressed: () {
                        WaiterAuth().signOut();

                        Navigator.pushReplacement(
                            context, pageRoute(child: TabletSignIn()));
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.logout),
                          SizedBox(
                            width: size.width * 0.04,
                          ),
                          const Text('LogOut')
                        ],
                      )),
                  decoration: const BoxDecoration(
                      border:
                          Border(top: const BorderSide(color: Colors.black))),
                ))
              ];
            })
          ],
        ),
        body: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
            stream: firebaseCommand().gettable(),
            builder: (context, snapshots) {
              final table = snapshots.data;
              if (!snapshots.hasData) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 255, 147, 7).withOpacity(0.5),
                ));
              } else if (snapshots.hasData) {
                return SingleChildScrollView(
                  child: Container(
                    height: size.height - 100,
                    child: ListView.builder(
                        itemCount: table!.size,
                        itemBuilder: (context, index) {
                          return CommandColumn(size, snapshots, index, table);
                        }),
                  ),
                );
              }
              return Container(
                color: Colors.white,
                height: size.height,
                width: size.width,
                child: SizedBox(
                  height: size.height * 0.7,
                  width: size.width * 0.5,
                  child: Lottie.asset(
                    'assets/noOrder.json',
                  ),
                ),
              );
            },
          ),
        ));
  }

  Column CommandColumn(
      Size size,
      AsyncSnapshot<QuerySnapshot<Object?>> snapshots,
      int j,
      QuerySnapshot<Object?> table) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.zero,
          alignment: Alignment.center,
          height: size.height * 0.1,
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
                      const Color.fromARGB(255, 255, 166, 0),
                      const Color.fromARGB(255, 255, 145, 0),
                    ],
                  )),
          ),
        ),
        StreamBuilder<List<ModelCommand>>(
          stream: firebaseCommand().getCommand(
              table.docs[j]['floor'], table.docs[j]['table']), //flor,table
          builder: (context, snaps) {
            if (!snaps.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snaps.hasData) {
              List<ModelCommand> command = snaps.data!;

              for (int jj = 0; jj < table.size; jj++) {
                return Container(
                  margin: const EdgeInsets.all(8),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.red)),
                  height: size.height * 0.4,
                  child: Column(
                    children: [
                      AnimatedContainer(
                          height: size.height * 0.03,
                          duration: const Duration(seconds: 1),
                          child: command[jj].isReady == false
                              ? const Text(
                                  'In Progress...',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 97, 55, 0),
                                  ),
                                )
                              : const Text(
                                  ' Order Is Ready',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 252, 38, 0),
                                  ),
                                )),
                      Container(
                        padding: EdgeInsets.zero,
                        height: size.height * 0.2,
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: command.length.compareTo(0),
                            itemBuilder: (context, i) {
                              return Card(
                                child: ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      width: size.width * 0.2,
                                      child: Image.network(command[i].image),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    command[i].name,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  trailing: Text('\$${command[i].itemPrice}',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.amber)),
                                ),
                              );
                            }),
                      ),
                      command[jj].friesPrice == 0
                          ? Container()
                          : SizedBox(
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
                                  width: size.width * 0.05,
                                ),
                                Text(
                                  command[jj].fries,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: size.width * 0.6,
                                ),
                                Text('\$${command[jj].friesPrice}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.amber))
                              ]),
                            ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total : ',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            Text('\$${command[jj].total}',
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.amber)),
                          ],
                        ),
                      ),
                      if (!load) ...[
                        command[jj].isReady == false
                            ? ElevatedButton(
                                onPressed: () {
                                  firebaseCommand().commanReady(
                                      table.docs[j]['floor'],
                                      table.docs[j]['table']);
                                },
                                style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    padding: EdgeInsets.zero,
                                    primary: const Color.fromARGB(
                                        255, 233, 200, 11)),
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
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  firebaseCommand().commandDelete(
                                      table.docs[jj]['floor'],
                                      table.docs[jj]['table']!);
                                  firebaseCommand().tableDelete(
                                      table.docs[jj]['floor'],
                                      table.docs[jj]['table']);
                                },
                                style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    padding: EdgeInsets.zero,
                                    primary: const Color.fromARGB(
                                        255, 233, 200, 11)),
                                child: Container(
                                    alignment: Alignment.center,
                                    height: size.height * 0.04,
                                    width: size.width * 0.3,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color.fromARGB(255, 233, 11, 11),
                                          Color.fromARGB(255, 253, 59, 0)
                                        ],
                                      ),
                                    ),
                                    child: const Text('Delete This Order !')),
                              ),
                      ]
                    ],
                  ),
                );
              }
              return Center(
                child: Container(
                  color: Colors.white,
                  height: size.height,
                  width: size.width,
                  child: SizedBox(
                    height: size.height * 0.7,
                    width: size.width * 0.5,
                    child: Lottie.asset(
                      'assets/noOrder.json',
                    ),
                  ),
                ),
              );
            } else {
              return Container(
                color: Colors.white,
                height: size.height,
                width: size.width,
              );
            }
          },
        ),
      ],
    );
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