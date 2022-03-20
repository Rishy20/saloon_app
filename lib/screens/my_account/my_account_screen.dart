import 'package:flutter/material.dart';
import 'package:saloon_app/screens/my_account/components/body.dart';

class MyAccountScreen extends StatelessWidget {
  static String routeName = '/profile/my_account';

  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        centerTitle: true,
      ),
      body: const Body(),
    );
  }
}