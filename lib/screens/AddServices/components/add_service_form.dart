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

class AddServiceForm extends StatefulWidget {
  @override
  _AddServiceFormState createState() => _AddServiceFormState();
}

class _AddServiceFormState extends State<AddServiceForm> {
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();
  File? imageFile;
  bool imageError = false;
  bool isSaving = false;

  TextEditingController name = new TextEditingController();
  TextEditingController price = new TextEditingController();
  TextEditingController description = new TextEditingController();


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
    double height = MediaQuery.of(context).size.height - 200;
    return isSaving
        ? Container(
            width: double.infinity,
            alignment: Alignment.center,
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Saving Service",
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
          )
        : Form(
            key: _formKey,
            child: Column(children: [
              buildTextFormField(
                  label: "Service",
                  hint: "Enter service name",
                  error: "Please enter a service name",
                  controller: name,
                  type: "text"),
              buildTextFormField(
                  label: "Price",
                  hint: "Enter service price",
                  error: "Please enter the price",
                  controller: price,
                  type: "text"),
              buildMultiLineFormField(
                  label: "Description",
                  hint: "Enter service description",
                  error: "Please enter the description",
                  controller: description,
                  type: "text"),
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
                  text: "Upload Image",
                  press: () {
                    _getFromGallery();
                  }),
              SizedBox(height: 5),
              imageError
                  ? FormError(error: "Please upload an image")
                  : Container(),
              SizedBox(
                height: 20,
              ),
              SecondaryButton(
                  text: "Submit",
                  press: () async {
                    if (imageFile == null) {
                      setState(() {
                        imageError = true;
                      });
                    }
                    if (_formKey.currentState!.validate() && !imageError) {
                      Service service = Service();
                      service.name = name.text;
                      service.price = price.text;
                      service.description = description.text;
                      setState(() {
                        isSaving = true;
                      });
                      ServiceService serviceService = ServiceService();
                      var imageUrl =
                          await serviceService.uploadServiceImage(imageFile!);
                      service.image = imageUrl;
                      serviceService.addService(service);
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
        imageError = false;
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
