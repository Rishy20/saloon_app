import 'package:flutter/widgets.dart';
import 'package:saloon_app/screens/addSpecialists/add_specialist_screen.dart';
import 'package:saloon_app/screens/addUsers/add_user_screen.dart';
import 'package:saloon_app/screens/allSpecialists/all_specialist_screen.dart';
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
  AddServicesScreen.routeName: (context) => const AddServicesScreen(),
  AllServiceScreen.routeName: (context) => const AllServiceScreen(),
  EditServicesScreen.routeName: (context) => const EditServicesScreen()
  AllUsersScreen.routeName: (context) => const AllUsersScreen(),
  AddUsersScreen.routeName: (context) => const AddUsersScreen(),
  EditUsersScreen.routeName: (context) => const EditUsersScreen()
};
