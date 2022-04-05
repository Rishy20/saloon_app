import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saloon_app/providers/hairStylesProvider.dart';
import 'package:saloon_app/providers/loginInfoProvider.dart';
import 'package:saloon_app/providers/specialistProvider.dart';
import 'package:saloon_app/routes.dart';
import 'package:saloon_app/screens/home/home_screen.dart';
import 'package:saloon_app/screens/splash/splash_screen.dart';
import 'package:saloon_app/theme.dart';
import 'package:saloon_app/providers/serviceProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: SpecialistsProvider()),
    ChangeNotifierProvider.value(value: LoginInfoProvider()),
    ChangeNotifierProvider.value(value: ServicesProvider()),
    ChangeNotifierProvider.value(value: HairStylesProvider()),
  ], child: MyApp()));
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
        initialRoute: SplashScreen.routeName,
        routes: routes);
  }
}
