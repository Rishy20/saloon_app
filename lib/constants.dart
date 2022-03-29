import 'package:flutter/material.dart';
import 'package:saloon_app/size_config.dart';

const kPrimaryColor = Color(0xFF111111);
const kPrimaryContrastColor = Color(0xFF1b1b1b);
const kPrimaryDarkColor = Color(0xFF172F4B);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFFE0B277);
const kButtonColor = Color(0xFFE1B378);
const kTextColor = Colors.white;
const kPlaceholderColor = Color(0xFF636363);
const kBorderColor = Color(0xFFE8E8E8);
const kGreyBorder = Color(0xFFE5E5E5);
const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: kSecondaryColor,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please enter your email";
const String kInvalidEmailError = "Please enter a valid email";
const String kPassNullError = "Please enter your password";
const String kNewPassNullError = "Please enter a new password";
const String kShortPassError = "Password is too weak";
const String kMatchPassError = "Passwords don't match";
const String kNameNullError = "Please enter your name";
const String kPhoneNumberNullError = "Please enter your phone number";
const String kAddressNullError = "Please enter your address";
const String kEmailOrPasswordError = "Email or password is incorrect";
const String kPasswordIncorrectError = "Password is incorrect";
const String kSomethingWrongError = "Something went wrong, please try again...";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}

// Default avatar image
const String defaultAvatar = "https://firebasestorage.googleapis.com/v0/b/saloon-app-88797.appspot.com/o/uploads%2Fusers%2Favatar.jpg?alt=media&token=48f39178-4b59-4043-b819-146519c2f801";
