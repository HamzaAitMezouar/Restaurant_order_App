import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:restaurant_menu/controller/itemController.dart';
import 'package:restaurant_menu/models/items.dart';
import 'package:restaurant_menu/pages/foodTypes/dessert.dart';
import 'package:restaurant_menu/widgets/Shimmer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../utils/routeAnimation.dart';
import '../../widgets/FadeAnimation.dart';
import 'dart:ui' as ui;

class beverage extends StatelessWidget {
  int floor;
  int table;
  String type;
  Size size;
  beverage(
      {Key? key,
      required this.floor,
      required this.table,
      required this.type,
      required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                          image: AssetImage('assets/bev.jpg'),
                          fit: BoxFit.cover)),
                ),
              ),
            ),
            FadeAnimation(
                1.5,
                StreamBuilder<List<Item>>(
                  stream: itemController().getItemsByType(type),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Shimmerpage();
                    } else if (snapshot.hasData) {
                      List<Item> items = snapshot.data!;
                      return SizedBox(
                        height: size.height * 0.7,
                        child: MasonryGridView.count(
                          padding: EdgeInsets.zero,
                          itemCount: items.length,
                          crossAxisCount: 2,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          itemBuilder: (context, index) {
                            return FadeAnimation(
                                1.8,
                                InkWell(
                                  onTap: () {
                                    dialogdessert(context);
                                  },
                                  child: Container(
                                    height: index % 3 == 0
                                        ? size.height * 0.3
                                        : index == 2
                                            ? size.height * 0.35
                                            : size.height * 0.35,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: size.height * 0.008,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              '\$${items[index].price}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  foreground: Paint()
                                                    ..shader =
                                                        ui.Gradient.linear(
                                                      const Offset(0, 20),
                                                      const Offset(150, 20),
                                                      <Color>[
                                                        const Color.fromARGB(
                                                            255, 0, 129, 43),
                                                        const Color.fromARGB(
                                                            255, 15, 230, 87),
                                                      ],
                                                    )),
                                            ),
                                            SizedBox(
                                              width: size.width * 0.04,
                                            )
                                          ],
                                        ),
                                        Container(
                                          padding: EdgeInsets.zero,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      items[index].image),
                                                  fit: BoxFit.contain)),
                                          height: index % 3 == 0
                                              ? size.height * 0.2
                                              : index == 4
                                                  ? size.height * 0.25
                                                  : size.height * 0.23,
                                        ),
                                        Text(
                                          items[index].name,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              foreground: Paint()
                                                ..shader = ui.Gradient.linear(
                                                  const Offset(0, 20),
                                                  const Offset(150, 20),
                                                  <Color>[
                                                    const Color.fromARGB(
                                                        255, 0, 129, 43),
                                                    const Color.fromARGB(
                                                        255, 15, 230, 87),
                                                  ],
                                                )),
                                        )
                                      ],
                                    ),
                                  ),
                                ));
                          },
                        ),
                      );
                    } else {
                      return Shimmerpage();
                    }
                  },
                ))
          ],
        ));
  }

  Future<dynamic> dialogdessert(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          width: size.width * 0.4,
        ),
        title: Text(
          'Desserts ?',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              foreground: Paint()
                ..shader = ui.Gradient.linear(
                  const Offset(0, 20),
                  const Offset(150, 20),
                  <Color>[
                    Color.fromARGB(255, 155, 22, 22),
                    Color.fromARGB(255, 255, 145, 0),
                  ],
                )),
        ),
        elevation: 2,
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No')),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    pageRoute(
                        child: dessert(
                            floor: floor,
                            table: table,
                            type: 'dessert',
                            size: size)));
              },
              child: const Text('Yes'))
        ],
      ),
    );
  }
}
