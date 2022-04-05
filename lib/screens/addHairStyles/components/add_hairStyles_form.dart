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

class AddHairStylesForm extends StatefulWidget {
  @override
  _AddHairStylesFormState createState() => _AddHairStylesFormState();
}

class _AddHairStylesFormState extends State<AddHairStylesForm> {
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();
  List<File> imageFiles = [];
  bool imageError = false;
  bool genderError = false;
  bool isSaving = false;
  List<String> gender = ["Male", "Female"];
  String? selectedGender;

  TextEditingController style = new TextEditingController();
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
                    "Saving Hair Styles",
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
                  label: "Style",
                  hint: "Enter Hair Style Name",
                  error: "Please enter a name",
                  controller: style,
                  type: "text"),
              buildSelectField(
                  label: "Gender",
                  hint: "Select a Gender",
                  error: "Please select a gender"),
              buildMultiLineFormField(
                  label: "Description",
                  hint: "Enter Hair Styles Description",
                  error: "Please enter description",
                  controller: description,
                  type: "text"),
              imageFiles.length > 0
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Container(
                        height: 130,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              ...List.generate(
                                imageFiles.length,
                                (index) => Stack(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.all(10),
                                        child: Image.file(
                                          imageFiles[index],
                                          width: 120,
                                          fit: BoxFit.cover,
                                        )),
                                    Positioned(
                                      top: 0,
                                      right:
                                          0, //give the values according to your requirement
                                      child: GestureDetector(
                                        onTap: () => {
                                          setState(() {
                                            imageFiles.removeAt(index);
                                          })
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: Colors.red),
                                          child: Icon(
                                            Icons.cancel,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                      ),
                    )
                  : Container(),
              PrimaryButton(
                  text: "Upload Hair Style Image",
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
                    if (imageFiles.isEmpty) {
                      setState(() {
                        imageError = true;
                      });
                    }
                    if (selectedGender == null) {
                      genderError = true;
                    }
                    if (_formKey.currentState!.validate() &&
                        !imageError &&
                        !genderError) {
                      HairStyles hairStyles = HairStyles();
                      hairStyles.style = style.text;
                      hairStyles.description = description.text;
                      hairStyles.gender = selectedGender!;
                      setState(() {
                        isSaving = true;
                      });
                      HairStylesService hairStylesService = HairStylesService();
                      List<String> images = [];

                      for (var image in imageFiles) {
                        var imageUrl = await hairStylesService
                            .uploadHairStylesImage(image);
                        images.add(imageUrl);
                      }

                      hairStyles.image = images;

                      hairStylesService.addHairStyle(hairStyles);
                      Navigator.pushNamed(
                          context, AllHairStylesScreen.routeName);
                    }
                  })
            ]));
  }

  Column buildSelectField({
    label: String,
    hint: String,
    error: String,
  }) {
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
        Container(
          padding: EdgeInsets.only(top: 8, left: 16, bottom: 8, right: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: kPrimaryContrastColor,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
                isExpanded: true,
                value: selectedGender,
                borderRadius: BorderRadius.circular(8),
                items: gender.map((String val) {
                  return new DropdownMenuItem<String>(
                    value: val,
                    child: new Text(val),
                  );
                }).toList(),
                hint: Text(
                  hint,
                  style: TextStyle(color: kPlaceholderColor, fontSize: 18),
                ),
                onChanged: (newVal) {
                  setState(() {
                    selectedGender = newVal!;
                    genderError = false;
                  });
                }),
          ),
        ),
        genderError ? FormError(error: error) : Container(),
        SizedBox(
          height: getProportionateScreenWidth(20),
        ),
      ],
    );
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
        imageFiles.add(croppedImage);
        imageError = false;
      });
    }
  }
}
