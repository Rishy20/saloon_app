import 'package:flutter/material.dart';
import 'package:saloon_app/components/no_account_text.dart';
import 'package:saloon_app/constants.dart';
import 'package:saloon_app/size_config.dart';
import '../sign_in_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                'Welcome Back',
                style: headingStyle,
              ),
              const Text(
                'Sign in with your email and password',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.08),
              const SignInForm(),
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              SizedBox(height: getProportionateScreenHeight(20)),
              const NoAccountText()
            ],
          ),
        ),
      )
    );
  }
}
