import 'package:flutter/material.dart';
import 'package:saloon_app/components/home_item_card.dart';
import 'package:saloon_app/constants.dart';
import 'package:saloon_app/providers/specialistProvider.dart';
import 'package:saloon_app/screens/allSpecialists/all_specialist_screen.dart';

class HomeItemGroup extends StatelessWidget {
  const HomeItemGroup({
    Key? key,
    required this.specialistsProvider,
  }) : super(key: key);

  final SpecialistsProvider specialistsProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Specialists",
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w600,color: kSecondaryColor),
              ),
              GestureDetector(
                onTap: () =>{
                   Navigator.pushNamed(
                    context, AllSpecialistScreen.routeName)
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600,),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
         Container(
           height: 200,
           child: ListView(
          scrollDirection: Axis.horizontal,
          
          children:[ ...List.generate(specialistsProvider.allSpecialists.length,
      (index) => HomeItemCard(image: specialistsProvider.allSpecialists[index].image, title: specialistsProvider.allSpecialists[index].firstName)),
          ]),
         )
      ],
    );
  }
}

