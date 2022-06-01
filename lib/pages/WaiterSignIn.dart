import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'package:lottie/lottie.dart';
import 'package:restaurant_menu/controller/firebase/waiterAuth.dart';
import 'package:restaurant_menu/utils/constant.dart';
import 'package:restaurant_menu/widgets/FadeAnimation.dart';
import 'dart:ui' as ui;

import 'TablesPage.dart';

class WaiterSignIn extends StatefulWidget {
  const WaiterSignIn({Key? key}) : super(key: key);

  @override
  State<WaiterSignIn> createState() => _WaiterSignInState();
}

class _WaiterSignInState extends State<WaiterSignIn> {
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
                          Color.fromARGB(255, 21, 168, 82),
                          Color.fromARGB(255, 44, 248, 129)
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
                        child: Lottie.asset('assets/burger.json'),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                'Waiter ',
                style: TextStyle(
                    fontSize: 28,
                    foreground: Paint()
                      ..shader = ui.Gradient.linear(
                        const Offset(0, 100),
                        const Offset(150, 20),
                        <Color>[
                          Constants().green,
                          const Color.fromARGB(255, 44, 248, 129)
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
                                    WaiterAuth().signIn(email, password);
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
                                                  TablesPage()));
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
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Constants().green,
                                          const Color.fromARGB(
                                              255, 44, 248, 129)
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
                                    WaiterAuth().signUp(email, password, name);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TablesPage()));
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
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Constants().green,
                                          const Color.fromARGB(
                                              255, 44, 248, 129)
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
                        elevation: 0, shadowColor: Constants().green),
                    onPressed: () {
                      setState(() {
                        SignIn = !SignIn;
                      });
                    },
                    child: Text(
                      SignIn
                          ? 'Click Here to Create new Account!'
                          : 'ClickHere to sign In !',
                      style: TextStyle(color: Constants().green),
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
          hoverColor: Constants().green,
          labelStyle: TextStyle(color: Constants().green),
          prefixIcon: Icon(
            icon,
            color: Constants().green,
          ),
          label: const Text('Email'),
          iconColor: Constants().green,
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
        style: TextStyle(
          color: Constants().green,
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
          hoverColor: Constants().green,
          labelStyle: TextStyle(color: Constants().green),
          prefixIcon: Icon(
            icon,
            color: Constants().green,
          ),
          label: const Text('Password'),
          iconColor: Constants().green,
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
          hoverColor: Constants().green,
          labelStyle: TextStyle(color: Constants().green),
          prefixIcon: Icon(
            icon,
            color: Constants().green,
          ),
          label: const Text('userName'),
          iconColor: Constants().green,
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
        style: TextStyle(
          color: Constants().green,
        ),
      ),
    );
  }
}
