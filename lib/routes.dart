import 'package:flutter/widgets.dart';
import 'package:saloon_app/screens/addSpecialists/add_specialist_screen.dart';
import 'package:saloon_app/screens/home/home_screen.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  AddSpecialistsScreen.routeName: (context) => AddSpecialistsScreen(),

};
