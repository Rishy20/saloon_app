import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saloon_app/components/bottom_nav_bar.dart';
import 'package:saloon_app/constants.dart';
import 'package:saloon_app/enums.dart';
import 'package:saloon_app/screens/home/components/body.dart';
import 'package:saloon_app/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saloon", style: GoogleFonts.marckScript(fontSize: 36)),
        centerTitle: true,
        leading: IconButton(
            onPressed: () async {
              String googleUrl =
                  'https://www.google.com/maps/search/?api=1&query=6.932202,79.9528444';
              if (await canLaunch(googleUrl)) {
                await launch(googleUrl);
              } else {
                throw 'Could not open the map.';
              }
            },
            icon: Icon(
              Icons.location_on,
              color: kSecondaryColor,
              size: 30,
            )),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
              padding: const EdgeInsets.all(14.0),
              child: IconButton(
                  onPressed: () async {
                    const url = "tel:0767232507";
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  icon: Icon(Icons.call, color: kSecondaryColor, size: 30)))
        ],
      ),
      body: Body(),
      bottomNavigationBar: BottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
