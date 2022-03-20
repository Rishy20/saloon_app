import 'package:flutter/material.dart';
import './components/body.dart';

class SignUpSuccessScreen extends StatelessWidget {
  static String routeName = '/sign_up_success';

  const SignUpSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Success'),
        centerTitle: true,
      ),
      body: const Body(),
    );
  }
}