import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_menu/controller/provider/FloorTableProvider.dart';
import 'package:restaurant_menu/pages/CommandReady.dart';
import 'package:restaurant_menu/utils/routeAnimation.dart';

import '../widgets/FadeAnimation.dart';
import '../widgets/FutureBuilder.dart';

class home extends StatelessWidget {
  int floor;
  int table;
  home({required this.floor, required this.table});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, pageRoute(child: CommandReady()));
                },
                icon: const Icon(Icons.food_bank))
          ],
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Floor ${floor}'),
              Text('Table ${table}'),
            ],
          ),
        ),
        body: Column(
          children: [
            FadeAnimation(
              1.2,
              ClipPath(
                clipper: WaveClipperTwo(),
                child: Container(
                  alignment: Alignment.topCenter,
                  height: size.height * 0.25,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/burger1.jpg'),
                          fit: BoxFit.cover)),
                ),
              ),
            ),
            FutureBuilderClass(size: size, floor: floor, table: table),
          ],
        ));
  }
}
