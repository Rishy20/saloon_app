import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:saloon_app/components/custom_suffix_icon.dart';
import 'package:saloon_app/components/default_button.dart';
import 'package:saloon_app/components/form_error.dart';
import 'package:saloon_app/constants.dart';
import 'package:saloon_app/models/user.dart';
import 'package:saloon_app/providers/loginInfoProvider.dart';
import 'package:saloon_app/screens/home/home_screen.dart';
import 'package:saloon_app/size_config.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? confirmPassword;
  final List<String> errors = [];

  void addError({String error = ''}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String error = ''}) {
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
            buildEmailFormField(),
            FormError(
                error: errors.contains(kEmailNullError) ? kEmailNullError : ''),
            FormError(
                error: errors.contains(kInvalidEmailError)
                    ? kInvalidEmailError
                    : ''),
            SizedBox(height: getProportionateScreenHeight(32)),
            buildPasswordFormField(),
            FormError(
                error: errors.contains(kPassNullError) ? kPassNullError : ''),
            SizedBox(height: getProportionateScreenHeight(24)),
            FormError(
                error: errors.contains(kEmailOrPasswordError)
                    ? kEmailOrPasswordError
                    : ''),
            FormError(
                error: errors.contains(kSomethingWrongError)
                    ? kSomethingWrongError
                    : ''),
            SizedBox(height: getProportionateScreenHeight(24)),
            DefaultButton(
                text: "Sign In",
                press: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    _firestore
                        .collection('users')
                        .where('email', isEqualTo: email)
                        .where('password', isEqualTo: password)
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
                          'firstName': user.firstName,
                          'lastName': user.lastName,
                          'phoneNumber': user.phoneNumber,
                          'address': user.address,
                          'avatar': user.avatar
                        };

                        // Set login info
                        LoginInfoProvider().setLoginInfo(userMap);

                        // Navigate to home page
                        Navigator.pushNamed(context, HomeScreen.routeName);
                      } else {
                        addError(error: kEmailOrPasswordError);
                      }
                    }).catchError(
                            (error) => addError(error: kSomethingWrongError));
                  }
                }),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, HomeScreen.routeName),
                child: const Text(
                  "Skip",
                  style: TextStyle(color: kPrimaryColor, fontSize: 18),
                ),
              ),
            )
          ],
        ));
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        onSaved: (newValue) => email = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kEmailNullError);
          } else if (emailValidatorRegExp.hasMatch(value)) {
            removeError(error: kInvalidEmailError);
          }
          removeError(error: kEmailOrPasswordError);
          removeError(error: kSomethingWrongError);
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kEmailNullError);
            return "";
          } else if (!emailValidatorRegExp.hasMatch(value)) {
            addError(error: kInvalidEmailError);
            return "";
          }
          return null;
        },
        decoration: const InputDecoration(
            labelText: 'Email',
            hintText: 'Enter your email',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: CustomSuffixIcon(svgIcon: 'assets/icons/Mail.svg')));
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        }
        if (value.length >= 8 || value.isEmpty) {
          removeError(error: kShortPassError);
        }
        removeError(error: kEmailOrPasswordError);
        removeError(error: kSomethingWrongError);
        password = value;
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
          labelText: 'Password',
          hintText: 'Enter your password',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(
            svgIcon: 'assets/icons/Lock.svg',
          )),
    );
  }
}
