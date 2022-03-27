import 'package:flutter/material.dart';
import 'package:saloon_app/enums.dart';
import 'package:saloon_app/screens/addSpecialists/add_specialist_screen.dart';
import 'package:saloon_app/screens/allSpecialists/all_specialist_screen.dart';
import 'package:saloon_app/screens/home/home_screen.dart';

import '../constants.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);
  final iconSize = 35.0;
  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFF62513c);
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: kPrimaryContrastColor,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -10),
              blurRadius: 20,
              color: kSecondaryColor.withOpacity(0.2),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  Icons.home,
                  color: MenuState.home == selectedMenu
                      ? kSecondaryColor
                      : inActiveIconColor,
                  size: iconSize,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, HomeScreen.routeName),
              ),
              IconButton(
                icon: Icon(
                  Icons.cut,
                  color: MenuState.services == selectedMenu
                      ? kSecondaryColor
                      : inActiveIconColor,
                  size: iconSize,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, HomeScreen.routeName),
              ),
              IconButton(
                icon: Icon(
                  Icons.calendar_today_outlined,
                  color: MenuState.appointments == selectedMenu
                      ? kSecondaryColor
                      : inActiveIconColor,
                  size: iconSize,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, HomeScreen.routeName),
              ),
              IconButton(
                icon: Icon(
                  Icons.verified_user,
                  color: MenuState.specialists == selectedMenu
                      ? kSecondaryColor
                      : inActiveIconColor,
                  size: iconSize,
                ),
                onPressed: () => Navigator.pushNamed(
                    context, AllSpecialistScreen.routeName),
              ),
              IconButton(
                icon: Icon(
                  Icons.supervised_user_circle_sharp,
                  color: MenuState.profile == selectedMenu
                      ? kSecondaryColor
                      : inActiveIconColor,
                  size: iconSize,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, HomeScreen.routeName),
              ),
            ],
          ),
        ));
  }
}
