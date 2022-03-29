import 'package:flutter/material.dart';
import 'package:saloon_app/screens/sign_up/components/body.dart';

import '../../size_config.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/sign_up";

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
        centerTitle: true,
      ),
      body: const Body(),
    );
  }
}