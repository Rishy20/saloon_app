import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saloon_app/models/user.dart';
import 'package:saloon_app/screens/editUser/components/edit_user_form.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
  User user;
  Body({required this.user});
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EditUserForm(user: widget.user)
                  ])
            ])));
  }
}
