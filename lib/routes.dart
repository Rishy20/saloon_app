import 'package:flutter/widgets.dart';
import 'package:saloon_app/screens/addSpecialists/add_specialist_screen.dart';
import 'package:saloon_app/screens/allSpecialists/all_specialist_screen.dart';
import 'package:saloon_app/screens/editSpecialist/edit_specialist_screen.dart';
import 'package:saloon_app/screens/home/home_screen.dart';
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
  AddSpecialistsScreen.routeName: (context) => const AddSpecialistsScreen(),
  AllSpecialistScreen.routeName: (context) => const AllSpecialistScreen(),
  EditSpecialistsScreen.routeName: (context) => const EditSpecialistsScreen()
};
