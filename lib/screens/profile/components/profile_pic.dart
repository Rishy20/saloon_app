import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/avatar.png')
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
                  side: const BorderSide(color: Colors.white)
                ),
                color: const Color(0xFFF5F6F9),
                child: SvgPicture.asset('assets/icons/Camera Icon.svg'),
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
}