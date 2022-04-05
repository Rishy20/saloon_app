import 'package:flutter/widgets.dart';
import 'package:saloon_app/screens/addAppointments/add_appointment_screen.dart';
import 'package:saloon_app/screens/addSpecialists/add_specialist_screen.dart';
import 'package:saloon_app/screens/adminHome/admin_home_screen.dart';
import 'package:saloon_app/screens/allAppointments/all_appointment_screen.dart';
import 'package:saloon_app/screens/addHairStyles/add_hairStyles_screen.dart';
import 'package:saloon_app/screens/addSpecialists/add_specialist_screen.dart';
import 'package:saloon_app/screens/allHairStyles/all_hairstyle_screen.dart';
import 'package:saloon_app/screens/allSpecialists/all_specialist_screen.dart';
import 'package:saloon_app/screens/editHairStyles/edit_hairStyles_screen.dart';
import 'package:saloon_app/screens/addUsers/add_user_screen.dart';
import 'package:saloon_app/screens/allSpecialists/all_specialist_screen.dart';
import 'package:saloon_app/screens/editAppointments/edit_appointment_screen.dart';
import 'package:saloon_app/screens/allUsers/all_users_screen.dart';
import 'package:saloon_app/screens/change_password/change_password_screen.dart';
import 'package:saloon_app/screens/editSpecialist/edit_specialist_screen.dart';
import 'package:saloon_app/screens/editUser/edit_user_screen.dart';
import 'package:saloon_app/screens/home/home_screen.dart';
import 'package:saloon_app/screens/AddServices/add_service_screen.dart';
import 'package:saloon_app/screens/allServices/all_services_screen.dart';
import 'package:saloon_app/screens/editService/edit_service_screen.dart';
import 'package:saloon_app/screens/my_account/my_account_screen.dart';
import 'package:saloon_app/screens/profile/profile_screen.dart';
import 'package:saloon_app/screens/sign_in/sign_in_screen.dart';
import 'package:saloon_app/screens/sign_up/sign_up_screen.dart';
import 'package:saloon_app/screens/sign_up_success/sign_up_success_screen.dart';
import 'package:saloon_app/screens/singleHairStyle/single_hair_style_screen.dart';
import 'package:saloon_app/screens/singleService/single_service_screen.dart';
import 'package:saloon_app/screens/singleSpecialist/single_specialist_screen.dart';
import 'package:saloon_app/screens/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  SignUpSuccessScreen.routeName: (context) => const SignUpSuccessScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  MyAccountScreen.routeName: (context) => const MyAccountScreen(),
  ChangePasswordScreen.routeName: (context) => const ChangePasswordScreen(),
  AddSpecialistsScreen.routeName: (context) => const AddSpecialistsScreen(),
  AllSpecialistScreen.routeName: (context) => const AllSpecialistScreen(),
  EditSpecialistsScreen.routeName: (context) => const EditSpecialistsScreen(),
  AddAppointmentScreen.routeName: (context) => const AddAppointmentScreen(),
  AllAppointmentsScreen.routeName: (context) => const AllAppointmentsScreen(),
  EditAppointmentScreen.routeName: (context) => const EditAppointmentScreen(),
  AdminHomeScreen.routeName: (context) => const AdminHomeScreen(),
  AddHairStylesScreen.routeName: (context) => const AddHairStylesScreen(),
  AllHairStylesScreen.routeName: (context) => const AllHairStylesScreen(),
  EditHairStylesScreen.routeName: (context) => const EditHairStylesScreen(),
  AddServicesScreen.routeName: (context) => const AddServicesScreen(),
  AllServiceScreen.routeName: (context) => const AllServiceScreen(),
  EditServicesScreen.routeName: (context) => const EditServicesScreen(),
  AllUsersScreen.routeName: (context) => const AllUsersScreen(),
  AddUsersScreen.routeName: (context) => const AddUsersScreen(),
  EditUsersScreen.routeName: (context) => const EditUsersScreen(),
  SingleHairStylesScreen.routeName: (context) => const SingleHairStylesScreen(),
  SingleSpecialistScreen.routeName: (context) => const SingleSpecialistScreen(),
  SingleServiceScreen.routeName: (context) => const SingleServiceScreen(),
  SplashScreen.routeName: (context) => const SplashScreen()
};
