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

class MyAccountForm extends StatefulWidget {
  const MyAccountForm({Key? key}) : super(key: key);

  @override
  _MyAccountFormState createState() => _MyAccountFormState();
}

class _MyAccountFormState extends State<MyAccountForm> {
  _MyAccountFormState() {
    setDetails();
  }

  final UserService _userService = UserService();
  final db = Localstore.instance;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  
  Map<String, dynamic> userMap = {
    'id': '',
    'email': '',
    'password': '',
    'firstName': '',
    'lastName': '',
    'phoneNumber': '',
    'address': '',
    'avatar': '',
  };

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  void setDetails() {
    db.collection('login').doc('loginData').get().then((value) {
      userMap = value!;
      _firstNameController.text = userMap['firstName'];
      _lastNameController.text = userMap['lastName'];
      _phoneNumberController.text = userMap['phoneNumber'];
      _addressController.text = userMap['address'];
    });
  }

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
          buildFirstNameFormField(),
          FormError(error: errors.contains(kNameNullError) ? kNameNullError : ''),
          SizedBox(height: getProportionateScreenHeight(32)),
          buildLastNameFormField(),
          FormError(error: errors.contains(kNameNullError) ? kNameNullError : ''),
          SizedBox(height: getProportionateScreenHeight(32)),
          buildPhoneNumberFormField(),
          FormError(error: errors.contains(kPhoneNumberNullError) ? kPhoneNumberNullError : ''),
          SizedBox(height: getProportionateScreenHeight(32)),
          buildAddressFormField(),
          FormError(error: errors.contains(kAddressNullError) ? kAddressNullError : ''),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: 'Save Changes',
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState?.save();

                User user = User();
                user.id = userMap['id'];
                user.email = userMap['email'];
                user.password = userMap['password'];
                user.firstName = userMap['firstName'];
                user.lastName = userMap['lastName'];
                user.phoneNumber = userMap['phoneNumber'];
                user.address = userMap['address'];
                user.avatar = userMap['avatar'];

                _userService.updateUser(user).then((value) {
                  LoginInfoProvider().setLoginInfo(userMap);
                  Navigator.pushNamed(context, ProfileScreen.routeName);
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
          controller: _addressController,
          onSaved: (newValue) => userMap['address'] = newValue ?? '',
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
            suffixIcon: CustomSuffixIcon(svgIcon: 'assets/icons/Location point.svg')
          )
        );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
          keyboardType: TextInputType.phone,
          controller: _phoneNumberController,
          onSaved: (newValue) => userMap['phoneNumber'] = newValue ?? '',
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
            suffixIcon: CustomSuffixIcon(svgIcon: 'assets/icons/Phone.svg')
          )
        );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
          keyboardType: TextInputType.name,
          controller: _lastNameController,
          onSaved: (newValue) => userMap['lastName'] = newValue ?? '',
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
            suffixIcon: CustomSuffixIcon(svgIcon: 'assets/icons/User.svg')
          )
        );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
          keyboardType: TextInputType.name,
          controller: _firstNameController,
          onSaved: (newValue) => userMap['firstName'] = newValue ?? '',
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
            suffixIcon: CustomSuffixIcon(svgIcon: 'assets/icons/User.svg')
          )
        );
  }
}