import 'package:flutter/widgets.dart';
import 'package:saloon_app/screens/addAppointments/add_appointment_screen.dart';
import 'package:saloon_app/screens/addSpecialists/add_specialist_screen.dart';
import 'package:saloon_app/screens/adminHome/admin_home_screen.dart';
import 'package:saloon_app/screens/allAppointments/all_appointment_screen.dart';
import 'package:saloon_app/screens/allSpecialists/all_specialist_screen.dart';
import 'package:saloon_app/screens/editAppointments/edit_appointment_screen.dart';
import 'package:saloon_app/screens/editSpecialist/edit_specialist_screen.dart';
import 'package:saloon_app/screens/home/home_screen.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  AddSpecialistsScreen.routeName: (context) => const AddSpecialistsScreen(),
  AllSpecialistScreen.routeName: (context) => const AllSpecialistScreen(),
  EditSpecialistsScreen.routeName: (context) => const EditSpecialistsScreen(),
  AddAppointmentScreen.routeName: (context) => const AddAppointmentScreen(),
  AllAppointmentsScreen.routeName: (context) => const AllAppointmentsScreen(),
  EditAppointmentScreen.routeName: (context) => const EditAppointmentScreen(),
  AdminHomeScreen.routeName: (context) => const AdminHomeScreen()
};
