import 'package:flutter/material.dart';
import 'package:saloon_app/constants.dart';
import 'package:saloon_app/models/hairStyles.dart';

class Body extends StatefulWidget {
  Body({Key? key, required this.hairstyle}) : super(key: key);
  HairStyles hairstyle = HairStyles();

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              widget.hairstyle.image[selectedImage],
              fit: BoxFit.contain,
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                  height: 80,
                  child: ListView(scrollDirection: Axis.horizontal, children: [
                    ...List.generate(
                        widget.hairstyle.image.length,
                        (index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedImage = index;
                                });
                              },
                              child: Container(
                                  margin: EdgeInsets.all(5),
                                  color: selectedImage == index
                                      ? kSecondaryColor
                                      : Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Image.network(
                                      widget.hairstyle.image[index],
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            ))
                  ]))),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text("Description",
                style: TextStyle(fontSize: 14, color: Colors.white60)),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 8, bottom: 8),
              child: Text(
                widget.hairstyle.description,
                style: TextStyle(fontSize: 20),
              ))
        ],
      ),
    );
  }
}
