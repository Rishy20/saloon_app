import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:provider/provider.dart';
import 'package:saloon_app/components/hairstyles_group.dart';
import 'package:saloon_app/components/services_group.dart';
import 'package:saloon_app/components/specialist_item_group.dart';
import 'package:saloon_app/providers/specialistProvider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SpecialistsProvider specialistsProvider =
        Provider.of<SpecialistsProvider>(context);

    return SafeArea(
      child: SingleChildScrollView(
          child: Column(
        children: [
          // TopBar(),
          ImageSlideshow(
              height: 180,
              indicatorColor: Colors.transparent,
              indicatorBackgroundColor: Colors.transparent,
              autoPlayInterval: 5000,
              isLoop: true,
              children: [
                Image.asset(
                  "assets/images/hero1.jpg",
                  fit: BoxFit.fill,
                ),
                Image.asset(
                  "assets/images/hero2.jpg",
                  fit: BoxFit.fill,
                ),
                Image.asset(
                  "assets/images/hero3.jpg",
                  fit: BoxFit.fill,
                )
              ]),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SpecialistItemGroup(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: HairStylesGroup(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ServicesGroup(),
          )
        ],
      )),
    );
  }
}
