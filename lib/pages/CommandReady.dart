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

                return Column(children: [
                  Container(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    height: size.height * 0.2,
                    child: ListView.builder(
                        itemCount: command!.size,
                        itemBuilder: (context, j) {
                          return Column(
                            children: [
                              Text(
                                'Command for Table ${snapshots.data!.docs[j]['table']} in floor ${snapshots.data!.docs[j]['floor']}',
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
                              StreamBuilder<List<ModelCommand>>(
                                  stream: firebaseCommand().getCommand(
                                      command.docs[j]['floor'],
                                      command.docs[j]['table']),
                                  builder: (context, snapshot) {
                                    print(snapshot.data!.length);
                                    List<ModelCommand> modelcom =
                                        snapshot.data!;
                                    print(modelcom.length);
                                    return ListView.builder(
                                        itemCount: modelcom.length,
                                        itemBuilder: (context, i) {
                                          return ListTile(
                                              title: Text(
                                                modelcom[i].name,
                                                style: const TextStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black),
                                              ),
                                              trailing: modelcom[i].isReady ==
                                                      true
                                                  ? Row(
                                                      children: const [
                                                        Text('Ready')
                                                      ],
                                                    )
                                                  : Row(
                                                      children: const [
                                                        Text('In Progress...')
                                                      ],
                                                    ));
                                        });
                                  })
                            ],
                          );
                        }),
                  )
                ]);
              }
            }));
  }
}
