
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

class EditUserForm extends StatefulWidget {
  @override
  _EditUserFormState createState() => _EditUserFormState();
  User user;
  EditUserForm({required this.user});
}

class _EditUserFormState extends State<EditUserForm> {
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();
  late User user;
  

  File? imageFile;

  TextEditingController firstName = new TextEditingController();
  TextEditingController lastName = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  TextEditingController address = new TextEditingController();

  void initState(){
    user = widget.user;

    firstName.text = user.firstName;
    lastName.text = user.lastName;
    email.text = user.email;
    password.text = user.password;
    phoneNumber.text = user.phoneNumber;
    address.text = user.address;

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
              type: "password"),
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
              
             imageFile == null && user.avatar != "" ? Padding(
                 padding: const EdgeInsets.only(bottom:16.0),
                 child: Container(
              child:  Image.network(
                  user.avatar,
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
              text: "Edit User Image",
              press: () {
                _getFromGallery();
              }),
              SizedBox(height: 20,),
             
          SecondaryButton(
              text: "Submit",
              press: () async{
                if (_formKey.currentState!.validate()) {
                  user.firstName = firstName.text;
                  user.lastName = lastName.text;
                  user.email = email.text;
                  user.password = password.text;
                  user.phoneNumber = phoneNumber.text;
                  user.address = address.text;

                  UserService userService = UserService();
                  if(imageFile != null){
                    var imageUrl = await userService.uploadUserImage(imageFile!);
                    user.avatar = imageUrl;
                  }
                  userService.updateUser(user);
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
            obscureText: type == "password" ? true : false,
            keyboardType: type == "password" ? TextInputType.text : type,
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
 