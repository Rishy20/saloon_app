import 'package:flutter/material.dart';
import 'package:saloon_app/components/bottom_nav_bar.dart';
import 'package:saloon_app/constants.dart';
import 'package:saloon_app/enums.dart';
import 'package:saloon_app/screens/addSpecialists/components/body.dart';
import 'package:saloon_app/size_config.dart';

class AddSpecialistsScreen extends StatelessWidget {
  static String routeName = "/specialists/add";

  const AddSpecialistsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      appBar: AppBar(
        title: Text("Add Specialist"),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavBar(selectedMenu: MenuState.specialists),
    );
  }

}
