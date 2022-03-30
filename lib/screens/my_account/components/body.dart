import 'package:flutter/cupertino.dart';
import 'package:saloon_app/screens/my_account/components/my_account_form.dart';
import 'package:saloon_app/size_config.dart';

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
              SizedBox(height: SizeConfig.screenHeight * 0.06),
              const MyAccountForm()
            ],
          )
        ),
      )
    );
  }
}