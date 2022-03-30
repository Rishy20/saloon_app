import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:provider/provider.dart';
import 'package:saloon_app/components/home_tem_group.dart';
import 'package:saloon_app/components/topbar.dart';
import 'package:saloon_app/constants.dart';
import 'package:saloon_app/providers/specialistProvider.dart';
import 'package:saloon_app/screens/allSpecialists/all_specialist_screen.dart';

class Body extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

  SpecialistsProvider specialistsProvider = Provider.of<SpecialistsProvider>(context);

    return SafeArea(
      child: SingleChildScrollView(
          child: Column(
        children: [
          // TopBar(),
           ImageSlideshow(
                height: 170,
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
            child: HomeItemGroup(specialistsProvider: specialistsProvider),
          )
        ],
      )),
    );
  }
}

