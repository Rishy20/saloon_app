import 'package:flutter/material.dart';
import 'package:saloon_app/components/bottom_nav_bar.dart';
import 'package:saloon_app/constants.dart';
import 'package:saloon_app/enums.dart';
import 'package:saloon_app/screens/addSpecialists/add_specialist_screen.dart';
import 'package:saloon_app/screens/allSpecialists/components/body.dart';

class AllSpecialistScreen extends StatelessWidget {
  static String routeName = "/specialists";

  const AllSpecialistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Specialists"),
        centerTitle: true,
        actions: [Padding(
          padding: const EdgeInsets.all(14.0),
          child: IconButton(
            onPressed:()=> {
              Navigator.pushNamed(
              context, AddSpecialistsScreen.routeName)
            } ,
            icon: Icon(Icons.add_circle,color: kSecondaryColor,size: 30)
          )),
        ],
      ),
      body: Body(),
            bottomNavigationBar: BottomNavBar(selectedMenu: MenuState.specialists),

    );
  }
}
