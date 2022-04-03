import 'package:flutter/material.dart';
import 'package:saloon_app/components/bottom_nav_bar.dart';
import 'package:saloon_app/constants.dart';
import 'package:saloon_app/enums.dart';
import 'package:saloon_app/models/service.dart';
import 'package:saloon_app/screens/editService/components/body.dart';
import 'package:saloon_app/size_config.dart';

class EditServicesScreen extends StatelessWidget {
  static String routeName = "/services/edit";

  const EditServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as ServiceDetailsArguments;
    return Scaffold(
      body: Body(
        service: arguments.service,
      ),
      appBar: AppBar(
        title: Text("Edit Service"),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavBar(selectedMenu: MenuState.services),
    );
  }
}

class ServiceDetailsArguments {
  final Service service;
  ServiceDetailsArguments({required this.service});
}
