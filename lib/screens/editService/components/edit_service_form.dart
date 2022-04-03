import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saloon_app/components/form_error.dart';
import 'package:saloon_app/components/primary_button.dart';
import 'package:saloon_app/components/secondary_button.dart';
import 'package:saloon_app/models/service.dart';
import 'package:saloon_app/screens/allServices/all_services_screen.dart';
import 'package:saloon_app/services/service.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class EditServiceForm extends StatefulWidget {
  @override
  _EditServiceFormState createState() => _EditServiceFormState();
  Service service;
  EditServiceForm({required this.service});
}

class _EditServiceFormState extends State<EditServiceForm> {
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();
  late Service service;

  File? imageFile;

  TextEditingController name = new TextEditingController();
  TextEditingController price = new TextEditingController();
  TextEditingController description = new TextEditingController();

  void initState() {
    service = widget.service;

    name.text = service.name;
    price.text = service.price;
    description.text = service.description;
  }

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
              hint: "Enter service",
              error: "Please enter a service",
              controller: name,
              type: "text"),
          buildTextFormField(
              label: "Price",
              hint: "Enter service price",
              error: "Please enter a price",
              controller: price,
              type: "text"),
          buildMultiLineFormField(
              label: "Description",
              hint: "Enter service description",
              error: "Please enter the description",
              controller: description,
              type: "text"),
          imageFile == null && service.image != ""
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Container(
                      child: Image.network(
                    service.image,
                    width: 150,
                    fit: BoxFit.cover,
                  )))
              : Container(),
          imageFile != null
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Container(
                      child: Image.file(
                    imageFile!,
                    width: 150,
                    fit: BoxFit.cover,
                  )),
                )
              : Container(),
          PrimaryButton(
              text: "Edit Service Image",
              press: () {
                _getFromGallery();
              }),
          SizedBox(
            height: 20,
          ),
          SecondaryButton(
              text: "Submit",
              press: () async {
                if (_formKey.currentState!.validate()) {
                  service.name = name.text;
                  service.price = price.text;
                  service.description = description.text;

                  ServiceService serviceService = ServiceService();
                  if (imageFile != null) {
                    var imageUrl =
                        await serviceService.uploadServiceImage(imageFile!);
                    service.image = imageUrl;
                  }
                  serviceService.updateService(service);
                  Navigator.pushNamed(context, AllServiceScreen.routeName);
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
Column buildMultiLineFormField(
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
            keyboardType: TextInputType.multiline,
            minLines: 4,
            maxLines: null,
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
  /// Get from gallery
  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1200,
      maxHeight: 1200,
    );
    if (pickedFile != null) {
      _cropImage(pickedFile.path);

      setState(() {
        // imageFile = File(pickedFile.path);
      });
    }
  }

  /// Crop Image
  _cropImage(filePath) async {
    ImageCropper cropper = ImageCropper();
    File? croppedImage = await cropper.cropImage(
      sourcePath: filePath,
      maxWidth: 1200,
      maxHeight: 1200,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: kPrimaryContrastColor,
          toolbarWidgetColor: kSecondaryColor,
          activeControlsWidgetColor: kSecondaryColor),
    );
    if (croppedImage != null) {
      setState(() {
        imageFile = croppedImage;
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
}
