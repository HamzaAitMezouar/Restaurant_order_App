import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_menu/controller/firebase/waiterAuth.dart';
import 'package:restaurant_menu/pages/CommandReady.dart';
import 'package:restaurant_menu/pages/Home.dart';
import 'package:restaurant_menu/pages/WaiterSignIn.dart';
import 'package:restaurant_menu/utils/constant.dart';
import 'package:restaurant_menu/widgets/FadeAnimation.dart';

import '../utils/routeAnimation.dart';

class TablesPage extends StatefulWidget {
  const TablesPage({Key? key}) : super(key: key);

  @override
  State<TablesPage> createState() => _TablesPageState();
}

class _TablesPageState extends State<TablesPage> {
  late int floor;
  late int table;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            actions: [
              PopupMenuButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  color: Colors.white.withOpacity(0.7),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                          child: InkWell(
                        child: Row(children: [
                          Icon(
                            Icons.food_bank,
                            color:
                                Color.fromARGB(255, 134, 0, 0).withOpacity(0.5),
                          ),
                          SizedBox(
                            width: size.width * 0.04,
                          ),
                          const Text('Orders State',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 134, 0, 0))),
                        ]),
                        onTap: () {
                          Navigator.push(
                              context, pageRoute(child: CommandReady()));
                        },
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

                              Navigator.pushReplacement(context,
                                  pageRoute(child: const WaiterSignIn()));
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
                            border: Border(
                                top: const BorderSide(color: Colors.black))),
                      ))
                    ];
                  })
            ],
            backgroundColor: Colors.transparent,
            bottom: TabBar(indicatorColor: Constants().green, tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [Text('Ground Floor')],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [Text('Second Floor')],
                ),
              )
            ]),
          ),
          body: TabBarView(children: [
            Container(
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/groundf.jpg'),
                              fit: BoxFit.cover)),
                      height: size.height * 0.21,
                    ),
                    Stack(
                      children: [
                        FadeAnimation(
                          1.2,
                          Container(
                            height: size.height * 0.7,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/PlanGround.jpg'),
                                    fit: BoxFit.fill)),
                          ),
                        ),
                        Positioned(
                          bottom: 140,
                          left: 95,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                floor = 1;
                                table = 1;
                                Navigator.push(
                                    context,
                                    pageRoute(
                                        child: home(
                                      floor: floor,
                                      table: table,
                                    )));
                              });
                            },
                            child: FadeAnimation(
                              1.4,
                              Container(
                                decoration: BoxDecoration(
                                    color: Constants().green,
                                    borderRadius: BorderRadius.circular(8)),
                                width: size.width * 0.1,
                                height: size.height * 0.0455,
                                child: const Text(
                                  'Table 1',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 145,
                          right: 92,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                floor = 1;
                                table = 2;
                                Navigator.push(
                                    context,
                                    pageRoute(
                                        child: home(
                                      floor: floor,
                                      table: table,
                                    )));
                              });
                            },
                            child: FadeAnimation(
                              1.4,
                              Container(
                                decoration: BoxDecoration(
                                    color: Constants().green,
                                    borderRadius: BorderRadius.circular(8)),
                                width: size.width * 0.1,
                                height: size.height * 0.05,
                                child: const Text(
                                  'Table 2',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 232,
                          right: 92,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                floor = 1;
                                table = 3;
                                Navigator.push(
                                    context,
                                    pageRoute(
                                        child: home(
                                      floor: floor,
                                      table: table,
                                    )));
                              });
                            },
                            child: FadeAnimation(
                              1.4,
                              Container(
                                decoration: BoxDecoration(
                                    color: Constants().green,
                                    borderRadius: BorderRadius.circular(8)),
                                width: size.width * 0.1,
                                height: size.height * 0.0455,
                                child: const Text(
                                  'Table 3',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            ///////////////////Flooooor 2 ///////////////
            Container(
              height: double.infinity,
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/rooftop.jpg'),
                            fit: BoxFit.cover)),
                    height: size.height * 0.21,
                  ),
                  Stack(
                    children: [
                      FadeAnimation(
                        1.4,
                        Container(
                          height: size.height * 0.7,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/planroof.jpg'),
                                  fit: BoxFit.fill)),
                        ),
                      ),
                      Positioned(
                        bottom: 135,
                        left: 91,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              floor = 2;
                              table = 1;
                              Navigator.push(
                                  context,
                                  pageRoute(
                                      child: home(
                                    floor: floor,
                                    table: table,
                                  )));
                            });
                          },
                          child: FadeAnimation(
                            1.5,
                            Container(
                              decoration: BoxDecoration(
                                  color: Constants().green,
                                  borderRadius: BorderRadius.circular(8)),
                              width: size.width * 0.14,
                              height: size.height * 0.038,
                              child: const Center(
                                child: Text(
                                  'Table 1',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 130,
                        right: 97,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              floor = 2;
                              table = 2;
                              Navigator.push(
                                  context,
                                  pageRoute(
                                      child: home(
                                    floor: floor,
                                    table: table,
                                  )));
                            });
                          },
                          child: FadeAnimation(
                            1.5,
                            Container(
                              decoration: BoxDecoration(
                                  color: Constants().green,
                                  borderRadius: BorderRadius.circular(8)),
                              width: size.width * 0.14,
                              height: size.height * 0.038,
                              child: const Center(
                                child: Text(
                                  'Table 2',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 257,
                        right: 97,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              floor = 2;
                              table = 3;
                              Navigator.push(
                                  context,
                                  pageRoute(
                                      child: home(
                                    floor: floor,
                                    table: table,
                                  )));
                            });
                          },
                          child: FadeAnimation(
                            1.5,
                            Container(
                              decoration: BoxDecoration(
                                  color: Constants().green,
                                  borderRadius: BorderRadius.circular(8)),
                              width: size.width * 0.14,
                              height: size.height * 0.038,
                              child: const Center(
                                child: Text(
                                  'Table 3',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 250,
                        left: 91,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              floor = 2;
                              table = 4;
                              Navigator.push(
                                  context,
                                  pageRoute(
                                      child: home(
                                    floor: floor,
                                    table: table,
                                  )));
                            });
                          },
                          child: FadeAnimation(
                            1.5,
                            Container(
                              decoration: BoxDecoration(
                                  color: Constants().green,
                                  borderRadius: BorderRadius.circular(8)),
                              width: size.width * 0.14,
                              height: size.height * 0.038,
                              child: const Center(
                                child: Text(
                                  'Table 4',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //Hiding Some Writing in Image
                      Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: size.width * 0.2,
                            height: size.height * 0.045,
                            color: Colors.white,
                          ))
                    ],
                  )
                ],
              ),
            ),
          ])),
    );
  }
}
