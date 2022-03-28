import 'package:flutter/widgets.dart';
import 'package:saloon_app/screens/addSpecialists/add_specialist_screen.dart';
import 'package:saloon_app/screens/allSpecialists/all_specialist_screen.dart';
import 'package:saloon_app/screens/editSpecialist/edit_specialist_screen.dart';
import 'package:saloon_app/screens/home/home_screen.dart';
import 'package:saloon_app/screens/AddServices/add_service_screen.dart';
import 'package:saloon_app/screens/allServices/all_services_screen.dart';
import 'package:saloon_app/screens/editService/edit_service_screen.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  AddSpecialistsScreen.routeName: (context) => const AddSpecialistsScreen(),
  AllSpecialistScreen.routeName: (context) => const AllSpecialistScreen(),
  EditSpecialistsScreen.routeName: (context) => const EditSpecialistsScreen(),
  AddServicesScreen.routeName: (context) => const AddServicesScreen(),
  AllServiceScreen.routeName: (context) => const AllServiceScreen(),
  EditServicesScreen.routeName: (context) => const EditServicesScreen()
};
