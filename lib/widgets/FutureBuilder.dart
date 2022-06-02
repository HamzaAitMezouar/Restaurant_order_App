// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_menu/controller/provider/CommandProvider.dart';
import 'package:restaurant_menu/pages/Command.dart';
import 'package:restaurant_menu/pages/foodTypes/beverage.dart';
import 'package:restaurant_menu/pages/foodTypes/burger.dart';
import 'package:restaurant_menu/widgets/FadeAnimation.dart';
import 'package:restaurant_menu/widgets/Shimmer.dart';

import '../controller/itemController.dart';
import '../models/items.dart';
import '../pages/foodTypes/dessert.dart';
import '../utils/routeAnimation.dart';

class FutureBuilderClass extends StatefulWidget {
  FutureBuilderClass(
      {Key? key, required this.size, required this.floor, required this.table})
      : super(key: key);

  final Size size;
  int floor;
  int table;

  @override
  FutureBuilderClassState createState() => FutureBuilderClassState(size: size);
}

class FutureBuilderClassState extends State<FutureBuilderClass> {
  final Size size;
  FutureBuilderClassState({
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final command = Provider.of<CommandProvider>(context);
    return OrientationBuilder(builder: (context, orientation) {
      final isPortrait = orientation == Orientation.portrait;
      return SingleChildScrollView(
        child: Column(
          children: [
            FadeAnimation(
              1.5,
              StreamBuilder<QuerySnapshot>(
                stream: itemController().getTypes(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    Container(
                        margin: EdgeInsets.all(8),
                        height: size.height * 0.6,
                        child: Shimmerpage());
                  }
                  if (snapshot.hasData) {
                    final items = snapshot.data!;

                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(8),
                          height: size.height * 0.65,
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: isPortrait ? 2 : 3,
                              crossAxisSpacing: 5.0,
                              mainAxisSpacing: 5.0,
                            ),
                            itemCount: items.size,
                            itemBuilder: (context, index) {
                              return FadeAnimation(
                                1.7,
                                InkWell(
                                  onTap: () {
                                    if (items.docs[index]['type'] == 'burger') {
                                      Navigator.push(
                                          context,
                                          pageRoute(
                                              child: burgers(
                                            floor: widget.floor,
                                            table: widget.table,
                                            size: size,
                                            type: 'burger',
                                          )));
                                    } else if (items.docs[index]['type'] ==
                                        'dessert') {
                                      Navigator.push(
                                          context,
                                          pageRoute(
                                              child: dessert(
                                            floor: widget.floor,
                                            table: widget.table,
                                            size: size,
                                            type: 'dessert',
                                          )));
                                    } else {
                                      Navigator.push(
                                          context,
                                          pageRoute(
                                              child: beverage(
                                            floor: widget.floor,
                                            table: widget.table,
                                            size: size,
                                            type: 'beverage',
                                          )));
                                    }
                                  },
                                  child: Column(
                                    children: [
                                      FadeAnimation(
                                        1.6,
                                        SizedBox(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            child: Image.network(
                                              items.docs[index]['image'],
                                              fit: BoxFit.fill,
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.amber
                                                        .withOpacity(0.4),
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes!
                                                        : null,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          height: size.height * 0.18,
                                          width: size.width * 0.45,
                                        ),
                                      ),
                                      FadeAnimation(
                                        1.7,
                                        SizedBox(
                                          height: size.height * 0.055,
                                          child: Text(items.docs[index]['type'],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color.fromARGB(
                                                          255, 150, 112, 0)
                                                      .withOpacity(0.8)),
                                              textAlign: TextAlign.center),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        // Confirm Bottons //////////////////////
                        FadeAnimation(
                          2,
                          SizedBox(
                            height: size.height * 0.06,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(
                                        size.width * 0.4,
                                        size.height * 0.05,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      primary: Colors.red,
                                      elevation: 2,
                                      shadowColor: Colors.amber),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    //   command.disposelist();
                                  },
                                  child: Text('Cancel'),
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: Size(
                                          size.width * 0.4,
                                          size.height * 0.05,
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18)),
                                        primary: Color.fromARGB(255, 0, 129, 4),
                                        elevation: 2,
                                        shadowColor: Colors.amber),
                                    onPressed: command.counter == 0
                                        ? null
                                        : () {
                                            Navigator.push(
                                                context,
                                                pageRoute(
                                                    child: Command(
                                                        floor: widget.floor,
                                                        table: widget.table)));
                                          },
                                    child: Text('Confirm (${command.counter})'))
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }
                  return Container(
                      margin: EdgeInsets.all(8),
                      height: size.height * 0.6,
                      child: Shimmerpage());
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
