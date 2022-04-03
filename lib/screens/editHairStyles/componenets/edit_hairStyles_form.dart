import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saloon_app/components/form_error.dart';
import 'package:saloon_app/components/primary_button.dart';
import 'package:saloon_app/components/secondary_button.dart';
import 'package:saloon_app/models/hairStyles.dart';
import 'package:saloon_app/screens/allHairStyles/all_hairstyle_screen.dart';
import 'package:saloon_app/services/hairStyles.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class EditHairStylesForm extends StatefulWidget {
  @override
  _EditHairStylesFormState createState() => _EditHairStylesFormState();
  HairStyles hairstyles;
  EditHairStylesForm({required this.hairstyles});
}

class _EditHairStylesFormState extends State<EditHairStylesForm> {
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();
  late HairStyles hairstyles;

  File? imageFile;

  TextEditingController styles = new TextEditingController();
  TextEditingController description = new TextEditingController();
  TextEditingController price = new TextEditingController();

  void initState() {
    hairstyles = widget.hairstyles;

    styles.text = hairstyles.style;
    description.text = hairstyles.description;
    price.text = hairstyles.price;
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
              label: "Styles",
              hint: "Enter Hair Styles",
              error: "Please enter a Styles",
              controller: styles,
              type: "text"),
          buildTextFormField(
              label: "Description",
              hint: "Enter Hair Styles Description",
              error: "Please enter description",
              controller: description,
              type: "text"),
          buildTextFormField(
              label: "Price",
              hint: "Enter Hair Styles price",
              error: "Please enter the price",
              controller: price,
              type: "number"),
          imageFile == null && hairstyles.image != ""
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Container(
                      child: Image.network(
                    hairstyles.image,
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
              text: "Edit Hair Styles Image",
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
                  hairstyles.style = styles.text ;
                  hairstyles.description = description.text;
                  hairstyles.price = price.text;

                  HairStylesService hairstylesService = HairStylesService();
                  if (imageFile != null) {
                    var imageUrl = await hairstylesService
                        .uploadHairStylesImage(imageFile!);
                    hairstyles.image = imageUrl;
                  }
                  hairstylesService.updateHairStyle(hairstyles);
                  Navigator.pushNamed(context, AllHairStylesScreen.routeName);
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
