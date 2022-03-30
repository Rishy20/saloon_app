import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saloon_app/providers/specialistProvider.dart';

import '../providers/loginInfoProvider.dart';

class ItemCard extends StatelessWidget {
  const ItemCard(
      {Key? key,
      required this.image,
      required this.title,
      required this.edit,
      required this.delete})
      : super(key: key);

  final String image;
  final String title;
  final GestureTapCallback edit;
  final GestureTapCallback delete;

  @override
  Widget build(BuildContext context) {
    LoginInfoProvider loginInfoProvider =
        Provider.of<LoginInfoProvider>(context);
    var loginInfo = loginInfoProvider.loginInfo;
    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 3,
      child: Column(
        children: [
          Expanded(child: Image.network(image)),
          Padding(
            padding: loginInfo != null && loginInfo['type'] == "admin" ? const EdgeInsets.only(top: 8.0) : EdgeInsets.only(top:8,bottom: 12),
            child: Text(title, style: Theme.of(context).textTheme.headline6),
          ),
          loginInfo != null && loginInfo['type'] == "admin"
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: edit,
                        icon: const Icon(Icons.edit,
                            color: Colors.white, size: 25)),
                    IconButton(
                        onPressed: delete,
                        icon: Icon(Icons.delete, color: Colors.white, size: 25))
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
