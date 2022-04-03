import 'package:flutter/material.dart';
import 'package:saloon_app/constants.dart';
import 'package:saloon_app/size_config.dart';
import '../sign_up_form.dart';

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
                'Register Account',
                style: headingStyle,
              ),
              const Text(
                'Fill in your details to continue',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.06),
              SignUpForm(),
              SizedBox(height: SizeConfig.screenHeight * 0.06),
              SizedBox(height: getProportionateScreenHeight(20)),
              const Text(
                "By continuing you confirm that you agree \nwith our Terms and Conditions",
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      )
    );
  }
}
