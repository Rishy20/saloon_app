import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:saloon_app/components/home_item_card.dart';
import 'package:saloon_app/constants.dart';
import 'package:saloon_app/models/hairStyles.dart';
import 'package:saloon_app/providers/hairStylesProvider.dart';
import 'package:saloon_app/providers/serviceProvider.dart';
import 'package:saloon_app/providers/specialistProvider.dart';
import 'package:saloon_app/screens/allHairStyles/all_hairstyle_screen.dart';
import 'package:saloon_app/screens/allServices/all_services_screen.dart';
import 'package:saloon_app/screens/allSpecialists/all_specialist_screen.dart';
import 'package:saloon_app/screens/editService/edit_service_screen.dart';
import 'package:saloon_app/screens/singleService/single_service_screen.dart';

class ServicesGroup extends StatelessWidget {
  const ServicesGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ServicesProvider servicesProvider = Provider.of<ServicesProvider>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Services",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: kSecondaryColor),
              ),
              GestureDetector(
                onTap: () =>
                    {Navigator.pushNamed(context, AllServiceScreen.routeName)},
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
                servicesProvider.allServices.length,
                (index) => GestureDetector(
                      onTap: () => {
                        Navigator.pushNamed(
                            context, SingleServiceScreen.routeName,
                            arguments: ServiceDetailsArguments(
                                service: servicesProvider.allServices[index]))
                      },
                      child: HomeItemCard(
                          image: servicesProvider.allServices[index].image,
                          title: servicesProvider.allServices[index].name),
                    )),
          ]),
        )
      ],
    );
  }
}
