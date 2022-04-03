import 'package:flutter/material.dart';
import 'package:saloon_app/components/bottom_nav_bar.dart';
import 'package:saloon_app/constants.dart';
import 'package:saloon_app/enums.dart';
import 'package:saloon_app/models/user.dart';
import 'package:saloon_app/screens/editUser/components/body.dart';
import 'package:saloon_app/size_config.dart';

class EditUsersScreen extends StatelessWidget {
  static String routeName = "/users/edit";

  const EditUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        final arguments =
        ModalRoute.of(context)!.settings.arguments as UserDetailsArguments;
    return Scaffold(
      body: Body(user: arguments.user,),
      appBar: AppBar(
        title: Text("Edit User"),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavBar(selectedMenu: MenuState.home),
    );
  }

}
class UserDetailsArguments {
  final User user;
  UserDetailsArguments({required this.user});
}