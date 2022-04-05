import 'package:flutter/material.dart';
import 'package:saloon_app/components/bottom_nav_bar.dart';
import 'package:saloon_app/constants.dart';
import 'package:saloon_app/enums.dart';
import 'package:saloon_app/models/hairStyles.dart';
import 'package:saloon_app/screens/editHairStyles/componenets/body.dart';
import 'package:saloon_app/size_config.dart';

class EditHairStylesScreen extends StatelessWidget {
  static String routeName = "/hairstyles/edit";

  const EditHairStylesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments
        as HairStylesDetailsArguments;
    return Scaffold(
      body: Body(
        hairstyles: arguments.hairstyles,
      ),
      appBar: AppBar(
        title: Text("Edit Hair Style"),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavBar(selectedMenu: MenuState.styles),
    );
  }
}

class HairStylesDetailsArguments {
  HairStyles hairstyles;
  HairStylesDetailsArguments({required this.hairstyles});
}
