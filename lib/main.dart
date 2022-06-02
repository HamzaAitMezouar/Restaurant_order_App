import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_menu/Responsive/Responsive.dart';
import 'package:restaurant_menu/controller/provider/CommandProvider.dart';

import 'package:restaurant_menu/pages/Tablet/TabletSignIn.dart';
import 'package:restaurant_menu/pages/WaiterSignIn.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*await Hive.initFlutter();
  Hive.registerAdapter(CommandHiveAdapter());
  await Hive.openBox<CommandHive>('command');
*/
  await Firebase.initializeApp();
  return runApp(Menu());
}

class Menu extends StatelessWidget {
  Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => CommandProvider(),
          ),
          /*  ChangeNotifierProvider(
            create: (_) => FloorTableProvider(),
          ),*/
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Our Menu',
            home: Responsive(
                mobile: const WaiterSignIn(), tablet: const TabletSignIn())));
  }
}
