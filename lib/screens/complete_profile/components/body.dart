import 'package:flutter/material.dart';
import 'package:saloon_app/constants.dart';
import 'package:saloon_app/size_config.dart';

import 'complete_profile_form.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.email,
    required this.password
  }) : super(key: key);

  final String email, password;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              Text(
                'Complete Profile',
                style: headingStyle,
              ),
              const Text(
                "Complete your details or continue\nwith social media",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.06),
              CompleteProfileForm(email: email, password: password),
              SizedBox(height: getProportionateScreenHeight(32)),
              const Text(
                'By continuing you confirm that you agree\nwith our Terms and Conditions',
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
