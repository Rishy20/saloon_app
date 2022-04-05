import 'package:flutter/material.dart';
import 'package:saloon_app/components/bottom_nav_bar.dart';
import 'package:saloon_app/enums.dart';
import 'package:saloon_app/screens/editSpecialist/edit_specialist_screen.dart';
import 'package:saloon_app/screens/singleSpecialist/components/body.dart';

class SingleSpecialistScreen extends StatelessWidget {
  static String routeName = "/specialists/single";

  const SingleSpecialistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments
        as SpecialistDetailsArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(arguments.specialist.firstName),
        centerTitle: true,
      ),
      body: Body(specialist: arguments.specialist),
      bottomNavigationBar: BottomNavBar(selectedMenu: MenuState.specialists),
    );
  }
}
