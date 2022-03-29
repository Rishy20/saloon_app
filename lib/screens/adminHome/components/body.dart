import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saloon_app/components/info_card.dart';
import 'package:saloon_app/constants.dart';

import '../../../components/topbar.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TopBar(),
      Expanded(
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return InfoCard(title: "Specialists", count: 10);
            }),
      )
    ]);
  }
}
