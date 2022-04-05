import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:saloon_app/components/form_error.dart';
import 'package:saloon_app/components/primary_button.dart';
import 'package:saloon_app/components/secondary_button.dart';
import 'package:saloon_app/models/appointment.dart';
import 'package:saloon_app/models/service.dart';
import 'package:saloon_app/providers/loginInfoProvider.dart';
import 'package:saloon_app/providers/specialistProvider.dart';
import 'package:saloon_app/screens/allAppointments/all_appointment_screen.dart';
import 'package:saloon_app/services/appointment.dart';
import 'package:saloon_app/services/service.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Choice {
  int id;
  String title;
  Choice({required this.id, required this.title});
}

class AddAppointmentForm extends StatefulWidget {
  @override
  _AddAppointmentFormState createState() => _AddAppointmentFormState();
}

class _AddAppointmentFormState extends State<AddAppointmentForm> {
  final _formKey = GlobalKey<FormState>();

  bool isSaving = false;
  bool isSubmit = false;
  DateTime selectedDate = DateTime.now();
  int selectedSpecialist = -1;
  int selectedSlot = -1;

  ServiceService serviceService = ServiceService();
  List<Service> services = [];
  List<Choice> options = [];
  List<MultiSelectItem<Choice>> items = [];

  Future<List<Service>> getAllServices() async {
    services = await serviceService.getAllServices();
    int index = 0;
    options = [];
    for (var service in services) {
      options.add(Choice(id: index, title: service.name));
      index++;
    }
    items = options
        .map((option) => MultiSelectItem<Choice>(option, option.title))
        .toList();
    return services;
  }

  void setSpecialist(int index) {
    setState(() {
      selectedSpecialist = index;
    });
  }

  void setSlot(int index) {
    setState(() {
      selectedSlot = index;
    });
  }

  final errors = {
    "date": "Please select a date",
    "specialist": "Please select a specialist",
    "service": "Please select a service",
    "slot": "Please select a slot"
  };

  List<String> slots = [
    "8:30 - 9:30 AM",
    "9:30 - 10:30 AM",
    "11:30 - 12:30 PM",
    "12:30 - 01:30 PM",
    "01:30 - 02:30 PM",
    "02:30 - 03:30 PM",
    "03:30 - 04:30 PM",
    "04:30 - 05:30 PM",
  ];

  List<Choice> selectedChoices = [];

  @override
  Widget build(BuildContext context) {
    SpecialistsProvider specialistsProvider =
        Provider.of<SpecialistsProvider>(context);
    double height = MediaQuery.of(context).size.height - 200;

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
            return isSaving
                ? Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    height: height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Saving Appointment",
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  )
                : Form(
                    key: _formKey,
                    child: Column(children: [
                      buildDatePicker(label: "Date"),
                      isSubmit && selectedDate == null
                          ? Column(
                              children: [
                                FormError(error: "Please select a date"),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            )
                          : Container(),
                      buildSpecialistSelector(specialistsProvider),
                      isSubmit && selectedSpecialist == -1
                          ? Column(
                              children: [
                                FormError(error: "Please select a specialist"),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            )
                          : Container(),
                      buildServiceSelector(context),
                      isSubmit && selectedChoices.isEmpty
                          ? Column(
                              children: [
                                FormError(error: "Please select a service"),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            )
                          : Container(),
                      buildSlotSelector(),
                      isSubmit && selectedSlot == -1
                          ? Column(
                              children: [
                                FormError(error: "Please select a slot"),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            )
                          : Container(),
                      SecondaryButton(
                          text: "Book Appointment",
                          press: () async {
                            if (selectedSpecialist != -1 ||
                                selectedSlot != -1 ||
                                selectedChoices.isNotEmpty) {
                              String specialistName =
                                  "${specialistsProvider.allSpecialists[selectedSpecialist].firstName} ${specialistsProvider.allSpecialists[selectedSpecialist].lastName}";
                              Appointment appointment = Appointment();
                              appointment.specialist = specialistsProvider
                                  .allSpecialists[selectedSpecialist].id;
                              appointment.date =
                                  "${selectedDate.toLocal()}".split(' ')[0];

                              List<String> services = [];
                              for (var choice in selectedChoices) {
                                services.add(choice.title);
                              }

                              appointment.service = services;
                              appointment.slot = slots[selectedSlot];
                              appointment.userId =
                                  Provider.of<LoginInfoProvider>(context,
                                          listen: false)
                                      .loginInfo["id"];

                              setState(() {
                                isSaving = true;
                              });
                              AppointmentService appointmentService =
                                  AppointmentService();

                              appointmentService.addAppointment(appointment);
                              Navigator.pushNamed(
                                  context, AllAppointmentsScreen.routeName);
                            } else {
                              setState(() {
                                isSubmit = true;
                              });
                            }
                          })
                    ]));
          }
        });
  }

  Column buildSlotSelector() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Slot",
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: getProportionateScreenWidth(16),
            color: Colors.white),
      ),
      SizedBox(
        height: getProportionateScreenWidth(5),
      ),
      Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          width: double.infinity,
          decoration: BoxDecoration(
              color: kPrimaryContrastColor,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 3 / 1,
            shrinkWrap: true,
            children: [
              ...List.generate(slots.length, (index) {
                return GestureDetector(
                  onTap: () => setSlot(index),
                  child: Chip(
                    elevation: 0,
                    padding: EdgeInsets.all(10),
                    backgroundColor:
                        selectedSlot == index ? kSecondaryColor : kPrimaryColor,
                    label: Text(
                      slots[index],
                      style: TextStyle(
                        fontSize: 14,
                        color:
                            selectedSlot == index ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                );
              })
            ],
          )),
      SizedBox(
        height: getProportionateScreenWidth(20),
      ),
    ]);
  }

  Column buildServiceSelector(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Service",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: getProportionateScreenWidth(16),
              color: Colors.white),
        ),
        SizedBox(
          height: getProportionateScreenWidth(5),
        ),
        GestureDetector(
          onTap: () => _showMultiSelect(context, "Select Services"),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            width: double.infinity,
            decoration: BoxDecoration(
                color: kPrimaryContrastColor,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: selectedChoices.length == 0
                ? Text(
                    "Select Service",
                    style: TextStyle(fontSize: 18, color: kPlaceholderColor),
                  )
                : MultiSelectChipDisplay<Choice>(
                    chipColor: kSecondaryColor,
                    textStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                    items: selectedChoices
                        .map((choice) => MultiSelectItem(choice, choice.title))
                        .toList(),
                    onTap: (value) {
                      setState(() {
                        selectedChoices.remove(value);
                      });
                    },
                  ),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
      ],
    );
  }

  Column buildSpecialistSelector(SpecialistsProvider specialistsProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Specialist",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: getProportionateScreenWidth(16),
              color: Colors.white),
        ),
        SizedBox(
          height: getProportionateScreenWidth(5),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: double.infinity,
          decoration: BoxDecoration(
              color: kPrimaryContrastColor,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            children: [
              ...List.generate(specialistsProvider.allSpecialists.length,
                  (index) {
                return GestureDetector(
                  onTap: () => setSpecialist(index),
                  child: Card(
                      margin: EdgeInsets.all(8.0),
                      elevation: 0,
                      child: Column(children: [
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Image.network(
                                specialistsProvider.allSpecialists[index].image,
                                width: 60),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: selectedSpecialist == index
                                      ? kSecondaryColor
                                      : Colors.transparent,
                                  width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                              specialistsProvider
                                  .allSpecialists[index].firstName,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: selectedSpecialist == index
                                      ? kSecondaryColor
                                      : Colors.white)),
                        ),
                      ])),
                );
              })
            ],
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
      ],
    );
  }

  void _showMultiSelect(BuildContext context, String title) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog<Choice>(
          items: items,
          initialValue: selectedChoices,
          backgroundColor: kPrimaryLightColor,
          itemsTextStyle: TextStyle(color: Colors.white),
          title: Text(title),
          selectedItemsTextStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          selectedColor: kSecondaryColor,
          unselectedColor: Colors.white,
          onConfirm: (values) {
            setState(() {
              selectedChoices = values;
            });
          },
        );
      },
    );
  }

  Column buildDatePicker({label: String}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: getProportionateScreenWidth(16),
              color: Colors.white),
        ),
        SizedBox(
          height: getProportionateScreenWidth(5),
        ),
        GestureDetector(
          onTap: () => buildMaterialDatePicker(context),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            width: double.infinity,
            decoration: BoxDecoration(
                color: kPrimaryContrastColor,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${selectedDate.toLocal()}".split(' ')[0],
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Icon(Icons.calendar_month, color: Colors.white)
              ],
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
      ],
    );
  }

  buildMaterialDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDatePickerMode: DatePickerMode.day,
      helpText: 'Select Appointment date',
      cancelText: 'Not now',
      confirmText: 'Book',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
      fieldLabelText: 'Appointment date',
      fieldHintText: 'Month/Date/Year',
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
