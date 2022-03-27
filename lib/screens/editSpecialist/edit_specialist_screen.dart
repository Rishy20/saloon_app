import 'package:flutter/material.dart';
import 'package:saloon_app/components/bottom_nav_bar.dart';
import 'package:saloon_app/constants.dart';
import 'package:saloon_app/enums.dart';
import 'package:saloon_app/models/specialist.dart';
import 'package:saloon_app/screens/editSpecialist/components/body.dart';
import 'package:saloon_app/size_config.dart';

class EditSpecialistsScreen extends StatelessWidget {
  static String routeName = "/specialists/edit";

  const EditSpecialistsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        final arguments =
        ModalRoute.of(context)!.settings.arguments as SpecialistDetailsArguments;
    return Scaffold(
      body: Body(specialist: arguments.specialist,),
      appBar: AppBar(
        title: Text("Edit Specialist"),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavBar(selectedMenu: MenuState.specialists),
    );
  }

}
class SpecialistDetailsArguments {
  final Specialist specialist;
  SpecialistDetailsArguments({required this.specialist});
}