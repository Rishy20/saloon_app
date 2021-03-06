import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saloon_app/providers/loginInfoProvider.dart';

import '../constants.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginInfoProvider loginInfoProvider =
        Provider.of<LoginInfoProvider>(context);
    var loginInfo = loginInfoProvider.loginInfo;
    return Container(
      padding: EdgeInsets.all(16),
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg5.jpg"),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                  kSecondaryColor.withOpacity(0.98), BlendMode.modulate)),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
          color: kSecondaryColor),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Text(
                loginInfo!= null?"Hi, ${loginInfo['firstName']}":"Hi, User",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 5,
              ),
              loginInfo!= null?Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 16,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "${loginInfo['address']}",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  )
                ],
              ):Container()
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Container(
            width: 85,
            height: 85,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(100)),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                child: Image.network(loginInfo!=null?loginInfo['avatar']:defaultAvatar),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
