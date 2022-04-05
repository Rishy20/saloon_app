import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:saloon_app/components/home_item_card.dart';
import 'package:saloon_app/constants.dart';
import 'package:saloon_app/models/hairStyles.dart';
import 'package:saloon_app/providers/hairStylesProvider.dart';
import 'package:saloon_app/providers/specialistProvider.dart';
import 'package:saloon_app/screens/allHairStyles/all_hairstyle_screen.dart';
import 'package:saloon_app/screens/allSpecialists/all_specialist_screen.dart';
import 'package:saloon_app/screens/editHairStyles/edit_hairStyles_screen.dart';
import 'package:saloon_app/screens/singleHairStyle/single_hair_style_screen.dart';

class HairStylesGroup extends StatelessWidget {
  const HairStylesGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HairStylesProvider hairStylesProvider =
        Provider.of<HairStylesProvider>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Hair Styles",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: kSecondaryColor),
              ),
              GestureDetector(
                onTap: () => {
                  Navigator.pushNamed(context, AllHairStylesScreen.routeName)
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 180,
          child: ListView(scrollDirection: Axis.horizontal, children: [
            ...List.generate(
                hairStylesProvider.allHairStyles.length,
                (index) => GestureDetector(
                      onTap: () => {
                        Navigator.pushNamed(
                            context, SingleHairStylesScreen.routeName,
                            arguments: HairStylesDetailsArguments(
                                hairstyles:
                                    hairStylesProvider.allHairStyles[index]))
                      },
                      child: HomeItemCard(
                          image:
                              hairStylesProvider.allHairStyles[index].image[0],
                          title: hairStylesProvider.allHairStyles[index].style),
                    )),
          ]),
        )
      ],
    );
  }
}
