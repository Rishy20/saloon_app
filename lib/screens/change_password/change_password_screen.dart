import 'package:flutter/material.dart';
import 'package:saloon_app/screens/change_password/components/body.dart';
import 'package:saloon_app/size_config.dart';

class ChangePasswordScreen extends StatelessWidget {
  static String routeName = '/profile/change_password';

  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        centerTitle: true,
      ),
      body: const Body(),
    );
  }
}