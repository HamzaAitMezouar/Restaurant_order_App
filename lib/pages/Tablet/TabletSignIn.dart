import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'package:lottie/lottie.dart';
import 'package:restaurant_menu/controller/firebase/cashierAuth.dart';
import 'package:restaurant_menu/controller/firebase/waiterAuth.dart';
import 'package:restaurant_menu/pages/Tablet/TabletCommand.dart';
import 'package:restaurant_menu/utils/constant.dart';
import 'package:restaurant_menu/widgets/FadeAnimation.dart';
import 'dart:ui' as ui;

class TabletSignIn extends StatefulWidget {
  const TabletSignIn({Key? key}) : super(key: key);

  @override
  State<TabletSignIn> createState() => TabletSignInState();
}

class TabletSignInState extends State<TabletSignIn> {
  late String email;
  late String name;
  late String password;
  bool SignIn = true;
  bool loading = false;
  TextEditingController emailcontroller = TextEditingController();
  final key = GlobalKey<FormState>();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  FadeAnimation(
                    1.2,
                    ClipPath(
                      clipper: WaveClipperOne(),
                      child: Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 245, 141, 5),
                          Color.fromARGB(255, 226, 222, 0)
                        ])),
                        height: size.height * 0.4,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 0,
                    left: 20,
                    child: FadeAnimation(
                      1.5,
                      SizedBox(
                        height: size.height * 0.3,
                        child: Lottie.asset('assets/cashier.json'),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                'Cashier',
                style: TextStyle(
                    fontSize: 28,
                    foreground: Paint()
                      ..shader = ui.Gradient.linear(
                        const Offset(0, 100),
                        const Offset(150, 20),
                        <Color>[
                          Color.fromARGB(255, 236, 56, 2),
                          const Color.fromARGB(255, 248, 200, 44)
                        ],
                      )),
              ),
              Form(
                  key: key,
                  child: SignIn
                      ? Column(
                          children: [
                            textFormField(
                                emailcontroller, 'email', Icons.email_rounded),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            passowrdtextFormField(passwordcontroller,
                                'password', Icons.lock_clock_rounded),
                            SizedBox(
                              height: size.height * 0.015,
                            ),
                            SizedBox(
                              height: size.height * 0.04,
                              width: size.width * 0.9,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (key.currentState!.validate() &&
                                      key.currentState != null) {
                                    CashierAuth().signIn(email, password);
                                    var user =
                                        FirebaseAuth.instance.currentUser;
                                    print(user);
                                    if (user == null) {
                                      return;
                                    } else {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const TabletCommand()));
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    padding: EdgeInsets.zero,
                                    primary: Colors.green.withOpacity(0.0)),
                                child: Container(
                                    alignment: Alignment.center,
                                    height: size.height * 0.04,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color.fromARGB(255, 233, 200, 11),
                                          Color.fromARGB(255, 100, 233, 11)
                                        ],
                                      ),
                                    ),
                                    child: const Text('Log in ')),
                              ),
                            )
                          ],
                        )
                      : Column(
                          children: [
                            nameFormField(nameController, 'name', Icons.person),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            textFormField(
                                emailcontroller, 'email', Icons.email_rounded),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            passowrdtextFormField(passwordcontroller,
                                'password', Icons.lock_clock_rounded),
                            SizedBox(
                              height: size.height * 0.015,
                            ),
                            SizedBox(
                              height: size.height * 0.04,
                              width: size.width * 0.9,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (key.currentState!.validate() &&
                                      key.currentState != null) {
                                    CashierAuth().signUp(email, password, name);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const TabletCommand()));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    padding: EdgeInsets.zero,
                                    primary: const Color.fromARGB(
                                        255, 233, 200, 11)),
                                child: Container(
                                    alignment: Alignment.center,
                                    height: size.height * 0.04,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color.fromARGB(255, 233, 200, 11),
                                          Color.fromARGB(255, 44, 248, 129)
                                        ],
                                      ),
                                    ),
                                    child: const Text('Register')),
                              ),
                            )
                          ],
                        )),
              SizedBox(
                height: size.height * 0.02,
              ),
              //change page//////////////////////
              Container(
                width: size.width * 0.9,
                child: TextButton(
                    style: TextButton.styleFrom(
                        elevation: 0,
                        shadowColor: const Color.fromARGB(255, 233, 200, 11)),
                    onPressed: () {
                      setState(() {
                        SignIn = !SignIn;
                      });
                    },
                    child: Text(
                      SignIn
                          ? 'Click Here to Create new Account!'
                          : 'ClickHere to sign In !',
                      style: const TextStyle(
                          color: const Color.fromARGB(255, 233, 200, 11)),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

//////////////////////////////////////
  Widget textFormField(
      TextEditingController controller, String valuekey, IconData icon) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      key: ValueKey(valuekey),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hoverColor: const Color.fromARGB(255, 233, 200, 11),
          labelStyle: const TextStyle(color: Color.fromARGB(255, 233, 200, 11)),
          prefixIcon: Icon(
            icon,
            color: const Color.fromARGB(255, 233, 200, 11),
          ),
          label: const Text('Email'),
          iconColor: const Color.fromARGB(255, 233, 200, 11),
        ),
        onChanged: (val) => setState(() {
          email = val;
        }),
        validator: (val) {
          String pattern =
              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
              r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
              r"{0,253}[a-zA-Z0-9])?)*$";
          RegExp regex = RegExp(pattern);
          if (val!.isEmpty || !regex.hasMatch(val)) {
            return 'Enter a valid email address';
          } else {
            return null;
          }
        },
        controller: controller,
        autocorrect: true,
        style: const TextStyle(
          color: Color.fromARGB(255, 233, 200, 11),
        ),
      ),
    );
  }

  Widget passowrdtextFormField(
      TextEditingController controller, String valuekey, IconData icon) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      key: ValueKey(valuekey),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          hoverColor: const Color.fromARGB(255, 233, 200, 11),
          labelStyle: TextStyle(color: Constants().green),
          prefixIcon: Icon(
            icon,
            color: const Color.fromARGB(255, 233, 200, 11),
          ),
          label: const Text(
            'Password',
            style: TextStyle(color: Color.fromARGB(255, 233, 200, 11)),
          ),
          iconColor: const Color.fromARGB(255, 233, 200, 11),
        ),
        onChanged: (val) => setState(() {
          password = val;
        }),
        validator: (val) {
          if (val!.isEmpty || val.length < 6) {
            return 'Enter a valid Password';
          } else {
            return null;
          }
        },
        controller: controller,
        autocorrect: true,
        style: TextStyle(
          color: Constants().green,
        ),
      ),
    );
  }

  Widget nameFormField(
      TextEditingController controller, String valuekey, IconData icon) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      key: ValueKey(valuekey),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hoverColor: const Color.fromARGB(255, 233, 200, 11),
          labelStyle:
              const TextStyle(color: const Color.fromARGB(255, 233, 200, 11)),
          prefixIcon: Icon(
            icon,
            color: const Color.fromARGB(255, 233, 200, 11),
          ),
          label: const Text('userName'),
          iconColor: const Color.fromARGB(255, 233, 200, 11),
        ),
        onChanged: (val) => setState(() {
          name = val;
        }),
        validator: (val) {
          if (val!.isEmpty || val.length < 4) {
            return 'Name Should have more than 4 charachters';
          } else {
            return null;
          }
        },
        controller: controller,
        autocorrect: true,
        style: const TextStyle(
          color: Color.fromARGB(255, 233, 200, 11),
        ),
      ),
    );
  }
}
