import 'package:flutter/material.dart';
import 'package:saloon_app/components/bottom_nav_bar.dart';
import 'package:saloon_app/enums.dart';
import 'package:saloon_app/screens/editHairStyles/edit_hairStyles_screen.dart';
import 'package:saloon_app/screens/singleHairStyle/components/body.dart';

class SingleHairStylesScreen extends StatelessWidget {
  static String routeName = "/hairstyles/single";

  const SingleHairStylesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments
        as HairStylesDetailsArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(arguments.hairstyles.style),
        centerTitle: true,
      ),
      body: Body(
        hairstyle: arguments.hairstyles,
      ),
      bottomNavigationBar: BottomNavBar(selectedMenu: MenuState.styles),
    );
  }
}
