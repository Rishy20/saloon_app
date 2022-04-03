import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saloon_app/components/item_card.dart';
import 'package:saloon_app/constants.dart';
import 'package:saloon_app/models/hairStyles.dart';
import 'package:saloon_app/models/specialist.dart';
import 'package:saloon_app/providers/specialistProvider.dart';
import 'package:saloon_app/screens/allHairStyles/all_hairstyle_screen.dart';
import 'package:saloon_app/screens/allSpecialists/all_specialist_screen.dart';
import 'package:saloon_app/screens/editHairStyles/edit_hairStyles_screen.dart';
import 'package:saloon_app/screens/editSpecialist/edit_specialist_screen.dart';
import 'package:saloon_app/services/hairStyles.dart';
import 'package:saloon_app/services/specialist.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Future<List<HairStyles>> allHairstyles;

  HairStylesService hairstylesService = HairStylesService();
  List<HairStyles> hairstyles = [];
  Future<List<HairStyles>> getAllHairStyles() async {
    hairstyles = await hairstylesService.getAllHairStyles();
    return hairstyles;
  }

  @override
  initState() {
    super.initState();
    allHairstyles = getAllHairStyles();
    print("All Hair Styles");
    print(allHairstyles);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return FutureBuilder(
        future: getAllHairStyles(),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [CircularProgressIndicator()],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: (itemWidth / itemHeight),
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    HairStylesService haristylesService = HairStylesService();
                    return ItemCard(
                        image: snapshot.data[index].image,
                        title: snapshot.data[index].style,
                        edit: () => {
                              Navigator.pushNamed(
                                  context, EditHairStylesScreen.routeName,
                                  arguments: HairStylesDetailsArguments(
                                      hairstyles: snapshot.data[index])),
                            },
                        delete: () {
                          showAlertDialog(context, snapshot.data[index].id);
                        });
                  }),
            );
          }
        });
  }

  showAlertDialog(BuildContext context, id) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget okButton = TextButton(
      child: Text("Ok"),
      onPressed: () {
        hairstylesService.removeHairStyles(id);
        Navigator.pushNamed(context, AllHairStylesScreen.routeName);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation"),
      content: Text("Do you want to delete?"),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
