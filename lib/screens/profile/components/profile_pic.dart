import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localstore/localstore.dart';
import 'package:saloon_app/constants.dart';

class ProfilePic extends StatelessWidget {
  ProfilePic({
    Key? key,
  }) : super(key: key);

  final _localstore = Localstore.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _localstore.collection('login').doc('loginData').get(),
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
                    onPressed: () async {
                      final FilePickerResult? image = await FilePicker.platform.pickFiles(allowMultiple: false);
      
                      // if (image != null) {
                      //   File file = File(image.files.single.path);
                      // } else {
                      // // User canceled the picker
                      // }
                    },
                  ),
                ),
              ),
            ]
          ),
        );
      }
    );
  }
}