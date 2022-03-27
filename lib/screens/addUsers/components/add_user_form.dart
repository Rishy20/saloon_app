
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saloon_app/components/form_error.dart';
import 'package:saloon_app/components/primary_button.dart';
import 'package:saloon_app/components/secondary_button.dart';
import 'package:saloon_app/models/user.dart';
import 'package:saloon_app/screens/allUsers/all_users_screen.dart';
import 'package:saloon_app/services/user.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class AddUserForm extends StatefulWidget {
  const AddUserForm({Key? key}) : super(key: key);

  @override
  _AddUserFormState createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();
  File? imageFile;
  bool imageError = false;
  bool isSaving = false;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController address = TextEditingController();

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
    double height = MediaQuery.of(context).size.height - 200;
    return isSaving?
        Container(
              width: double.infinity,
              alignment: Alignment.center,
              height: height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),

                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text("Saving User",style: TextStyle(fontSize: 16),),
                  )
                  ],
              ),
        ):Form(
        key: _formKey,
        child: Column(children: [
          buildTextFormField(
              label: "First Name",
              hint: "Enter users's first name",
              error: "Please enter a first name",
              controller: firstName,
              type: TextInputType.name),
              buildTextFormField(
              label: "Last Name",
              hint: "Enter users's last name",
              error: "Please enter a last name",
              controller: lastName,
              type: TextInputType.name),
              buildTextFormField(
              label: "Email",
              hint: "Enter users's email",
              error: "Please enter an email",
              controller: email,
              type: TextInputType.emailAddress),
              buildTextFormField(
              label: "Password",
              hint: "Enter users's password",
              error: "Please enter an password",
              controller: password,
              type: TextInputType.visiblePassword),
              buildTextFormField(
              label: "Phone Number",
              hint: "Enter users's phone number",
              error: "Please enter a phone number",
              controller: phoneNumber,
              type: TextInputType.phone),
              buildTextFormField(
              label: "Address",
              hint: "Enter users's address",
              error: "Please enter a address",
              controller: address,
              type: TextInputType.streetAddress),

              imageFile != null ? Padding(
                padding: const EdgeInsets.only(bottom:16.0),
                child: Image.file(
                imageFile!,
                width: 150,
                fit: BoxFit.cover,
                ),
               ):Container(),
               PrimaryButton(
              text: "Upload User Image",
              press: () {
                _getFromGallery();
              }),
              const SizedBox(height: 5),
              imageError?
              const FormError(error: "Please upload an image"):Container(),
              const SizedBox(height: 20,),
             
          SecondaryButton(
              text: "Submit",
              press: () async{
                if(imageFile == null){
                  setState(() {
                  imageError = true;
                    
                  });
                }
                if (_formKey.currentState!.validate() && !imageError) {
                  User user = User();
                  user.firstName = firstName.text;
                  user.lastName = lastName.text;
                  user.email = email.text;
                  user.password = password.text;
                  user.phoneNumber = phoneNumber.text;
                  user.address = address.text;
                  setState(() {
                  isSaving = true;
                    
                  });
                  UserService userService = UserService();
                  var imageUrl = await userService.uploadUserImage(imageFile!);
                  user.avatar = imageUrl;
                  userService.addUser(user);
                       Navigator.pushNamed(
            context, AllUsersScreen.routeName);
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
            keyboardType: type,
            controller: controller,
            style: const TextStyle(color: Colors.white),
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: error);
              }
              return;
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
      androidUiSettings: const AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: kPrimaryContrastColor,
          toolbarWidgetColor: kSecondaryColor,
          activeControlsWidgetColor:kSecondaryColor),
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
 