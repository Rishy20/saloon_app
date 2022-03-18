import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:saloon_app/routes.dart';
import 'package:saloon_app/screens/home/home_screen.dart';
import 'package:saloon_app/size_config.dart';
import 'package:saloon_app/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Saloon App',
        debugShowCheckedModeBanner: false,
        theme: theme(),
        initialRoute: HomeScreen.routeName,
        routes: routes);
  }
}
