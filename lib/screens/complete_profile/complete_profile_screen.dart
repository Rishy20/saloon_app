import 'package:flutter/material.dart';
import 'package:saloon_app/screens/complete_profile/components/body.dart';

class CompleteProfileScreen extends StatelessWidget {
  static String routeName = '/complete_profile';

  const CompleteProfileScreen({
    Key? key,
    required this.email,
    required this.password
  }) : super(key: key);

  final String email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
        centerTitle: true,
      ),
      body: Body(email: email, password: password),
    );
  }
}