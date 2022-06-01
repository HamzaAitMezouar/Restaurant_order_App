import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

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
