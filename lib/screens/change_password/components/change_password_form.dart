import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:localstore/localstore.dart';

import 'package:saloon_app/components/custom_suffix_icon.dart';
import 'package:saloon_app/components/default_button.dart';
import 'package:saloon_app/components/form_error.dart';
import 'package:saloon_app/models/user.dart';
import 'package:saloon_app/providers/loginInfoProvider.dart';
import 'package:saloon_app/screens/profile/profile_screen.dart';
import 'package:saloon_app/services/user.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({Key? key}) : super(key: key);

  @override
  _ChangePasswordFormState createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  _ChangePasswordFormState();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserService _userService = UserService();
  final db = Localstore.instance;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  
  String currentPassword = '';
  String newPassword = '';
  String confirmPassword = '';

  final TextEditingController _currentPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  void addError({ String? error }) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error!);
      });
    }
  }

  void removeError({ String? error }) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildCurrentPasswordFormField(),
          FormError(error: errors.contains(kPassNullError) ? kPassNullError : ''),
          FormError(error: errors.contains(kPasswordIncorrectError) ? kPasswordIncorrectError : ''),
          SizedBox(height: getProportionateScreenHeight(32)),
          buildNewPasswordFormField(),
          FormError(error: errors.contains(kNewPassNullError) ? kNewPassNullError : ''),
          FormError(error: errors.contains(kShortPassError) ? kShortPassError : ''),
          SizedBox(height: getProportionateScreenHeight(32)),
          buildConfirmPasswordFormField(),
          FormError(error: errors.contains(kMatchPassError) ? kMatchPassError : ''),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: 'Save Changes',
            press: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState?.save();

                var userMap = await Localstore.instance.collection('login').doc('loginData').get();

                _firestore
                  .collection('users')
                  .where('email', isEqualTo: userMap?['email'])
                  .where('password', isEqualTo: currentPassword)
                  .limit(1)
                  .get()
                  .then((QuerySnapshot snapshot) async {
                    if (snapshot.size > 0) {
                      String userId = snapshot.docs[0].id;
                      User user = User.fromSnapshot(snapshot.docs[0]);

                      // Create a map of user details
                      Map<String, dynamic> userMap = {
                        'id': userId,
                        'email': user.email,
                        'password': newPassword,
                        'firstName': user.firstName,
                        'lastName': user.lastName,
                        'phoneNumber': user.phoneNumber,
                        'address': user.address,
                        'avatar': user.avatar
                      };

                      // Set login info
                      LoginInfoProvider().setLoginInfo(userMap);

                      // Navigate to home page
                      Navigator.pushNamed(context, ProfileScreen.routeName);
                    } else {
                      addError(error: kPasswordIncorrectError);
                    }
                  }).catchError(
                    (error) => addError(error: kSomethingWrongError));
              }
            },
          )
        ],
      ),
    );
  }

  TextFormField buildConfirmPasswordFormField() {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.text,
      controller: _confirmPassword,
      onSaved: (newValue) => confirmPassword = newValue ?? '',
      onChanged: (value) {
        if (value == newPassword || newPassword.isEmpty) {
          removeError(error: kMatchPassError);
        }
        return;
      },
      validator: (value) {
        if (value != newPassword && newPassword.isNotEmpty) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: 'Confirm Password',
        hintText: 'Confirm the new password',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: 'assets/icons/Lock.svg')
      )
    );
  }

  TextFormField buildNewPasswordFormField() {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.text,
      controller: _newPassword,
      onSaved: (newValue) => newPassword = newValue ?? '',
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNewPassNullError);
        }
        if (value.length >= 8 || value.isEmpty) {
          removeError(error: kShortPassError);
        }
        newPassword = value;
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNewPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: 'New Password',
        hintText: 'Enter a new password',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: 'assets/icons/Lock.svg')
      )
    );
  }

  TextFormField buildCurrentPasswordFormField() {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.text,
      controller: _currentPassword,
      onSaved: (newValue) => currentPassword = newValue ?? '',
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: 'Current Password',
        hintText: 'Enter your password',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: 'assets/icons/Lock.svg')
      )
    );
  }
}