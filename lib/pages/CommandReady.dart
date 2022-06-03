// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_menu/pages/Command.dart';

import 'dart:ui' as ui;

import '../controller/firebase/FirebaseCommand.dart';
import '../models/ModelCommand.dart';

class CommandReady extends StatefulWidget {
  const CommandReady({Key? key}) : super(key: key);

  @override
  State<CommandReady> createState() => CommandReadyState();
}

class CommandReadyState extends State<CommandReady> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Orders '),
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
              );
            },
          ),
        )); /*SingleChildScrollView(
          child: SizedBox(
            height: size.height * 0.8,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.zero,
                  height: size.height * 0.15,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 0, 201, 77),
                    Color.fromARGB(255, 78, 245, 0)
                  ])),
                ),
                StreamBuilder<QuerySnapshot>(
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
                          return Column(children: [
                            Container(
                              height: 200,
                              child: ListView.builder(
                                itemCount: command.size,
                                itemBuilder: (context, i) => Container(
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color:
                                            const Color.fromARGB(255, 0, 82, 50)
                                                .withOpacity(0.8)),
                                  ),
                                  padding: EdgeInsets.zero,
                                  alignment: Alignment.center,
                                  height: size.height * 0.1,
                                  child: StreamBuilder<List<ModelCommand>>(
                                    stream: firebaseCommand().getCommand(
                                        command.docs[i]['floor'],
                                        command.docs[i]['table']),
                                    initialData: const <ModelCommand>[],
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      print('iiiiiiiiiiiii');
                                      print(command.docs[i]['table']);

                                      List<ModelCommand> check = snapshot.data;
                                      print('check[i].name,');
                                      print(
                                        check[i].name,
                                      );
                                      return Container(
                                        child: Column(
                                          children: [
                                            Text(
                                              'Command for Table ${snapshots.data!.docs[i]['table']} in floor ${snapshots.data!.docs[i]['floor']} ',
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                            Container(
                                                child: check[i].isReady == true
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          const Text(
                                                              ' Is Ready',
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          0,
                                                                          139,
                                                                          74),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                          SizedBox(
                                                            width: size.width *
                                                                0.1,
                                                          )
                                                        ],
                                                      )
                                                    : Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          const Text(
                                                              ' Still In Progress..',
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          204,
                                                                          41,
                                                                          0),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                          SizedBox(
                                                            width: size.width *
                                                                0.1,
                                                          )
                                                        ],
                                                      )),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            )
                          ]);
                        }
                        return Container();
                      }
                    }),
              ],
            ),
          ),
        ));*/
  }

  Column CommandColumn(
      Size size,
      AsyncSnapshot<QuerySnapshot<Object?>> snapshots,
      int j,
      QuerySnapshot<Object?> table) {
    return Column(
      children: [
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
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border:
                          Border.all(color: Color.fromARGB(255, 0, 128, 68))),
                  height: size.height * 0.1,
                  child: Column(
                    children: [
                      Text(
                        'Order For Table Number ${snapshots.data!.docs[j]['table']} in floor ${snapshots.data!.docs[j]['floor']}',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            foreground: Paint()
                              ..shader = ui.Gradient.linear(
                                const Offset(0, 20),
                                const Offset(150, 20),
                                <Color>[
                                  Color.fromARGB(255, 49, 32, 0),
                                  Color.fromARGB(255, 122, 69, 0),
                                ],
                              )),
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
                      AnimatedContainer(
                          alignment: Alignment.centerRight,
                          height: size.height * 0.03,
                          duration: const Duration(seconds: 1),
                          child: command[jj].isReady == false
                              ? const Text(
                                  'In Progress...  ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 184, 12, 0),
                                  ),
                                )
                              : const Text(
                                  ' Order Is Ready  ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 0, 95, 29),
                                  ),
                                )),
                    ],
                  ),
                );
              }
              return Center(
                child: Container(
                  color: Colors.white,
                  height: size.height,
                  width: size.width,
                ),
              );
            } else {
              return Center(
                child: Container(
                  color: Colors.white,
                  height: size.height,
                  width: size.width,
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
