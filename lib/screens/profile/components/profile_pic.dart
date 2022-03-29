import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localstore/localstore.dart';
import 'package:saloon_app/constants.dart';
import 'package:saloon_app/models/user.dart';
import 'package:saloon_app/providers/loginInfoProvider.dart';
import 'package:saloon_app/services/user.dart';

class ProfilePic extends StatelessWidget {
  ProfilePic({
    Key? key,
  }) : super(key: key);

  final localstore = Localstore.instance;
  final userService = UserService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: localstore.collection('login').doc('loginData').get(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        String avatar = snapshot.data != null ? snapshot.data["avatar"] : defaultAvatar;
        
        return SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            fit: StackFit.expand,
            overflow: Overflow.visible,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(avatar)
              ),
              Positioned(
                right: -12,
                bottom: 0,
                child: SizedBox(
                  height: 46,
                  width: 46,
                  child: FlatButton(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: const BorderSide(color: kSecondaryColor)
                    ),
                    color: kPrimaryColor,
                    child: SvgPicture.asset('assets/icons/Camera Icon.svg', color: kSecondaryColor,),
                    onPressed: _getFromGallery
                  ),
                ),
              ),
            ]
          ),
        );
      }
    );
  }

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
      _updateUserInfo(croppedImage);
    }
  }

  _updateUserInfo(image) async {
    var loginInfo =  await Localstore.instance.collection('login').doc('loginData').get();

    var imageUrl = await userService.uploadUserImage(image);
    
    if (loginInfo != null) {
      loginInfo['avatar'] = imageUrl;
      
      LoginInfoProvider().setLoginInfo(loginInfo);

      User user = User();
      user.id = loginInfo['id'];
      user.email = loginInfo['email'];
      user.password = loginInfo['password'];
      user.firstName = loginInfo['firstName'];
      user.lastName = loginInfo['lastName'];
      user.phoneNumber = loginInfo['phoneNumber'];
      user.address = loginInfo['address'];
      user.avatar = loginInfo['avatar'];

      userService.updateUser(user);
    }
  }
}