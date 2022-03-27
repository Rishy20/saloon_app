import 'package:flutter/material.dart';
import 'package:saloon_app/components/bottom_nav_bar.dart';
import 'package:saloon_app/constants.dart';
import 'package:saloon_app/enums.dart';
import 'package:saloon_app/screens/AddServices/components/body.dart';
import 'package:saloon_app/size_config.dart';

class AddServicesScreen extends StatelessWidget {
  static String routeName = "/services/add";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      appBar: AppBar(
        title: Text("Add Service"),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavBar(selectedMenu: MenuState.services),
    );
  }

// AppBar buildAppBar(BuildContext context) {
//   return AppBar(
//     centerTitle: true,
//     title: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text("Add Specialists"),
//       ],
//     ),
//   );
// }
}
