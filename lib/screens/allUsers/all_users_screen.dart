import 'package:flutter/material.dart';
import 'package:saloon_app/components/bottom_nav_bar.dart';
import 'package:saloon_app/constants.dart';
import 'package:saloon_app/enums.dart';
import 'package:saloon_app/screens/addUsers/add_user_screen.dart';
import 'package:saloon_app/screens/allUsers/components/body.dart';

class AllUsersScreen extends StatelessWidget {
  static String routeName = "/users";

  const AllUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Users"),
        centerTitle: true,
        actions: [Padding(
          padding: const EdgeInsets.all(14.0),
          child: IconButton(
            onPressed:()=> {
              Navigator.pushNamed(
              context, AddUsersScreen.routeName)
            } ,
            icon: const Icon(Icons.add_circle,color: kSecondaryColor,size: 30)
          )),
        ],
      ),
      body: Body(),
            bottomNavigationBar: const BottomNavBar(selectedMenu: MenuState.home),

    );
  }
}
