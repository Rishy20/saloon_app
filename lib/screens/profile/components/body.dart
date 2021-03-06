import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'package:provider/provider.dart';
import 'package:saloon_app/providers/loginInfoProvider.dart';
import 'package:saloon_app/screens/change_password/change_password_screen.dart';
import 'package:saloon_app/screens/home/home_screen.dart';
import 'package:saloon_app/screens/my_account/my_account_screen.dart';
import 'package:saloon_app/screens/profile/components/profile_pic.dart';
import 'profile_menu.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20,),
        ProfilePic(),
        const SizedBox(height: 40,),
        ProfileMenu(
          icon: 'assets/icons/User Icon.svg',
          text: 'My Account',
          press: () {
            Navigator.pushNamed(context, MyAccountScreen.routeName);
          }
        ),
        ProfileMenu(
          icon: 'assets/icons/Lock.svg',
          text: 'Change Password',
          press: () {
            Navigator.pushNamed(context, ChangePasswordScreen.routeName);
          }
        ),
        ProfileMenu(
          icon: 'assets/icons/Log out.svg',
          text: 'Log Out',
          press: () {
            Localstore.instance.collection('login').doc('loginData').delete().then((value) {
              Provider.of<LoginInfoProvider>(context,listen: false).logout();
              Navigator.pushNamed(context, HomeScreen.routeName);
            }
            );
          }
        ),
      ],
    );
  }
}
