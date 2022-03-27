import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saloon_app/models/specialist.dart';
import 'package:saloon_app/screens/editSpecialist/components/edit_specialist_form.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
  Specialist specialist;
  Body({required this.specialist});
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
                    EditSpecialistForm(specialist: widget.specialist)
                  ])
            ])));
  }
}
