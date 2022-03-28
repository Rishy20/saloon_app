import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saloon_app/components/item_card.dart';
import 'package:saloon_app/constants.dart';
import 'package:saloon_app/models/service.dart';
import 'package:saloon_app/providers/serviceProvider.dart';
import 'package:saloon_app/screens/allServices/all_services_screen.dart';
import 'package:saloon_app/screens/editService/edit_service_screen.dart';
import 'package:saloon_app/services/service.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Future<List<Service>> allServices;

  ServiceService serviceService = ServiceService();
  List<Service> services = [];
  Future<List<Service>> getAllServices() async {
    services = await serviceService.getAllServices();
    return services;
  }

  @override
  initState() {
    super.initState();
    allServices = getAllServices();
    print("All Services");
    print(allServices);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    var servicesProvider = Provider.of<ServicesProvider>(context);

    return FutureBuilder(
        future: getAllServices(),
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
                    ServiceService serviceService = ServiceService();
                    return ItemCard(
                        image: snapshot.data[index].image,
                        title: snapshot.data[index].firstName,
                        edit: () => {
                              Navigator.pushNamed(
                                  context, EditServicesScreen.routeName,
                                  arguments: ServiceDetailsArguments(
                                      service: snapshot.data[index])),
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
        serviceService.removeService(id);
        Navigator.pushNamed(context, AllServiceScreen.routeName);
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
