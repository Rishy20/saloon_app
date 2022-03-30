import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:localstore/localstore.dart';

import 'package:saloon_app/components/custom_suffix_icon.dart';
import 'package:saloon_app/components/default_button.dart';
import 'package:saloon_app/components/form_error.dart';
import 'package:saloon_app/providers/loginInfoProvider.dart';
import 'package:saloon_app/screens/sign_up_success/sign_up_success_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm(
      {Key? key, required this.email, required this.password})
      : super(key: key);

  final String email, password;

  @override
  _CompleteProfileFormState createState() =>
      _CompleteProfileFormState(email: email, password: password);
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  _CompleteProfileFormState({required this.email, required this.password});

  final String email, password;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String firstName = '';
  String lastName = '';
  String phoneNumber = '';
  String address = '';

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error!);
      });
    }
  }

  void removeError({String? error}) {
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
          buildFirstNameFormField(),
          FormError(
              error: errors.contains(kNameNullError) ? kNameNullError : ''),
          SizedBox(height: getProportionateScreenHeight(32)),
          buildLastNameFormField(),
          FormError(
              error: errors.contains(kNameNullError) ? kNameNullError : ''),
          SizedBox(height: getProportionateScreenHeight(32)),
          buildPhoneNumberFormField(),
          FormError(
              error: errors.contains(kPhoneNumberNullError)
                  ? kPhoneNumberNullError
                  : ''),
          SizedBox(height: getProportionateScreenHeight(32)),
          buildAddressFormField(),
          FormError(
              error:
                  errors.contains(kAddressNullError) ? kAddressNullError : ''),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: 'Sign Up',
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState?.save();

                Map<String, dynamic> user = {
                  'email': email,
                  'password': password,
                  'firstName': firstName,
                  'lastName': lastName,
                  'phoneNumber': phoneNumber,
                  'address': address,
                  'avatar': defaultAvatar,
                  'type': "user"
                };

                _firestore.collection('users').add(user).then((value) {
                  user['id'] = value.id;
                  LoginInfoProvider().setLoginInfo(user);
                  Navigator.pushNamed(context, SignUpSuccessScreen.routeName);
                });
              }
            },
          )
        ],
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
        keyboardType: TextInputType.streetAddress,
        onSaved: (newValue) => address = newValue ?? '',
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kAddressNullError);
          }
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kAddressNullError);
            return "";
          }
          return null;
        },
        decoration: const InputDecoration(
            labelText: 'Address',
            hintText: 'Enter your address',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon:
                CustomSuffixIcon(svgIcon: 'assets/icons/Location point.svg')));
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
        keyboardType: TextInputType.phone,
        onSaved: (newValue) => phoneNumber = newValue ?? '',
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kPhoneNumberNullError);
          }
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kPhoneNumberNullError);
            return "";
          }
          return null;
        },
        decoration: const InputDecoration(
            labelText: 'Phone Number',
            hintText: 'Enter your phone number',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: CustomSuffixIcon(svgIcon: 'assets/icons/Phone.svg')));
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
        keyboardType: TextInputType.name,
        onSaved: (newValue) => lastName = newValue ?? '',
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kNameNullError);
          }
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kNameNullError);
            return "";
          }
          return null;
        },
        decoration: const InputDecoration(
            labelText: 'Last Name',
            hintText: 'Enter your last name',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: CustomSuffixIcon(svgIcon: 'assets/icons/User.svg')));
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
        keyboardType: TextInputType.name,
        onSaved: (newValue) => firstName = newValue ?? '',
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kNameNullError);
          }
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kNameNullError);
            return "";
          }
          return null;
        },
        decoration: const InputDecoration(
            labelText: 'First Name',
            hintText: 'Enter your first name',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: CustomSuffixIcon(svgIcon: 'assets/icons/User.svg')));
  }
}
