import 'package:flutter/material.dart';
import 'package:saloon_app/components/bottom_nav_bar.dart';
import 'package:saloon_app/enums.dart';
import 'package:saloon_app/screens/editService/edit_service_screen.dart';
import 'package:saloon_app/screens/singleService/components/body.dart';

class SingleServiceScreen extends StatelessWidget {
  static String routeName = "/service/single";

  const SingleServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as ServiceDetailsArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(arguments.service.name),
        centerTitle: true,
      ),
      body: Body(service: arguments.service),
      bottomNavigationBar: BottomNavBar(selectedMenu: MenuState.services),
    );
  }
}
