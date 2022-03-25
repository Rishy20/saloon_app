
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saloon_app/components/form_error.dart';
import 'package:saloon_app/components/primary_button.dart';
import 'package:saloon_app/components/secondary_button.dart';
import 'package:saloon_app/models/specialist.dart';
import 'package:saloon_app/screens/allSpecialists/all_specialist_screen.dart';
import 'package:saloon_app/services/specialist.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class EditSpecialistForm extends StatefulWidget {
  @override
  _EditSpecialistFormState createState() => _EditSpecialistFormState();
  Specialist specialist;
  EditSpecialistForm({required this.specialist});
}

class _EditSpecialistFormState extends State<EditSpecialistForm> {
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();
  late Specialist specialist;
  

  File? imageFile;

  TextEditingController fname = new TextEditingController();
  TextEditingController lname = new TextEditingController();
  TextEditingController contact = new TextEditingController();
  TextEditingController designation = new TextEditingController();

  void initState(){
    specialist = widget.specialist;

    fname.text = specialist.firstName;
    lname.text = specialist.lastName;
    contact.text = specialist.contact;
    designation.text = specialist.designation;

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
              label: "First Name",
              hint: "Enter specialists's first name",
              error: "Please enter a first name",
              controller: fname,
              type: "text"),
              buildTextFormField(
              label: "Last Name",
              hint: "Enter specialists's last name",
              error: "Please enter a last name",
              controller: lname,
              type: "text"),
              buildTextFormField(
              label: "Contact",
              hint: "Enter specialists's contact number",
              error: "Please enter a contact number",
              controller: contact,
              type: "number"),
              buildTextFormField(
              label: "Designation",
              hint: "Enter specialists's designation",
              error: "Please enter a designation",
              controller: designation,
              type: "text"),
              
             imageFile == null && specialist.image != "" ? Padding(
                 padding: const EdgeInsets.only(bottom:16.0),
                 child: Container(
              child:  Image.network(
                  specialist.image,
                  width: 150,
                  fit: BoxFit.cover,
              ))):Container(),

              imageFile != null ? Padding(
                 padding: const EdgeInsets.only(bottom:16.0),
                 child: Container(
              child:  Image.file(
                  imageFile!,
                  width: 150,
                  fit: BoxFit.cover,
              )),
               ):Container(),


               PrimaryButton(
              text: "Edit Specialist Image",
              press: () {
                _getFromGallery();
              }),
              SizedBox(height: 20,),
             
          SecondaryButton(
              text: "Submit",
              press: () async{
                if (_formKey.currentState!.validate()) {
                  specialist.firstName = fname.text;
                  specialist.lastName = lname.text;
                  specialist.contact = contact.text;
                  specialist.designation = designation.text;

                  SpecialistService specialistService = SpecialistService();
                  if(imageFile != null){
                    var imageUrl = await specialistService.uploadSpecialistImage(imageFile!);
                    specialist.image = imageUrl;
                  }
                  specialistService.updateSpecialist(specialist);
                   Navigator.pushNamed(
            context, AllSpecialistScreen.routeName);
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
          activeControlsWidgetColor:kSecondaryColor),
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
 