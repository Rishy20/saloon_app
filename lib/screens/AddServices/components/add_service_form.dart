import 'package:flutter/material.dart';
import 'package:saloon_app/components/form_error.dart';
import 'package:saloon_app/components/secondary_button.dart';
import 'package:saloon_app/models/service.dart';
import 'package:saloon_app/services/service.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class AddServiceForm extends StatefulWidget {
  @override
  _AddServiceFormState createState() => _AddServiceFormState();
}

class _AddServiceFormState extends State<AddServiceForm> {
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
              label: "Service",
              hint: "Enter Service",
              error: "Please enter a service",
              controller: name,
              type: "text"),
          SecondaryButton(
              text: "Submit",
              press: () {
                if (_formKey.currentState!.validate()) {
                  Service service = Service();
                  service.name = name.text;
                  ServiceService serviceService = ServiceService();
                  serviceService.addService(service);
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
