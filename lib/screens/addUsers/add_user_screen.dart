import 'package:flutter/material.dart';
import 'package:saloon_app/components/bottom_nav_bar.dart';
import 'package:saloon_app/constants.dart';
import 'package:saloon_app/enums.dart';
import 'package:saloon_app/screens/addUsers/components/body.dart';
import 'package:saloon_app/size_config.dart';

class AddUsersScreen extends StatelessWidget {
  static String routeName = "/users/add";

  const AddUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Body(),
      appBar: AppBar(
        title: Text("Add User"),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavBar(selectedMenu: MenuState.home),
    );
  }

}
