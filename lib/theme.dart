import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData theme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: kPrimaryColor,
    cardColor: Color(0XFF1b1b1b),
    fontFamily: "Muli",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: kPrimaryContrastColor),
    gapPadding: 10,
  );
  OutlineInputBorder focusedInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    // If  you are using latest version of flutter then lable text and hint text shown like this
    // if you r using flutter less then 1.20.* then maybe this is not working properly
    // if we are define our floatingLabelBehavior in our theme then it's not applayed
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    fillColor: kPrimaryContrastColor,
    filled: true,
    hintStyle: TextStyle(color: kPlaceholderColor, fontSize: 18),
    labelStyle: TextStyle(color: kTextColor),
    enabledBorder: outlineInputBorder,
    focusedBorder: focusedInputBorder,
    border: outlineInputBorder,
  );
}

TextTheme textTheme() {
  return TextTheme(
    headline1: TextStyle(color: kSecondaryColor),
    headline2: TextStyle(color: kSecondaryColor),
    headline3: TextStyle(color: kSecondaryColor),
    headline4: TextStyle(color: kSecondaryColor),
    headline5: TextStyle(color: kSecondaryColor),
    headline6: TextStyle(color: kSecondaryColor),
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: kPrimaryContrastColor,
    toolbarHeight: 70,
    elevation: 0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: kSecondaryColor,
      fontSize: 22,
      fontWeight: FontWeight.w600,
    ),
  );
}
