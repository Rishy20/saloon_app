import 'package:flutter/material.dart';
import 'package:saloon_app/components/form_error.dart';
import 'package:saloon_app/components/secondary_button.dart';
import 'package:saloon_app/models/specialist.dart';
import 'package:saloon_app/services/specialist.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class AddSpecialistForm extends StatefulWidget {
  @override
  _AddSpecialistFormState createState() => _AddSpecialistFormState();
}

class _AddSpecialistFormState extends State<AddSpecialistForm> {
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();

  TextEditingController name = new TextEditingController();

  void addError({String error = ''}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error = ''}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: [
          buildTextFormField(
              label: "Name",
              hint: "Enter specialists's name",
              error: "Please enter a name",
              controller: name,
              type: "text"),
          SecondaryButton(
              text: "Submit",
              press: () {
                if (_formKey.currentState!.validate()) {
                  Specialist specialist = Specialist();
                  specialist.firstName = name.text;
                  SpecialistService specialistService = SpecialistService();
                  specialistService.addSpecialist(specialist);
                }
              })
        ]));
  }

  Column buildTextFormField(
      {label: String,
      hint: String,
      error: String,
      controller: TextEditingController,
      type: String}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: getProportionateScreenWidth(16),
              color: Colors.white),
        ),
        SizedBox(
          height: getProportionateScreenWidth(5),
        ),
        TextFormField(
            keyboardType:
                type == "number" ? TextInputType.number : TextInputType.text,
            controller: controller,
            style: TextStyle(color: Colors.white),
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: error);
              }
              return null;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: error);
                return "";
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: hint,
            )),
        FormError(error: errors.contains(error) ? error : ''),
        SizedBox(height: getProportionateScreenHeight(20)),
      ],
    );
  }
}
