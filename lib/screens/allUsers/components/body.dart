import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saloon_app/components/item_card.dart';
import 'package:saloon_app/models/user.dart';
import 'package:saloon_app/providers/loginInfoProvider.dart';
import 'package:saloon_app/screens/allUsers/all_users_screen.dart';
import 'package:saloon_app/screens/editUser/edit_user_screen.dart';
import 'package:saloon_app/services/user.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Future <List<User>> allUsers;

  UserService userService = UserService();
  List<User> users = [];
  Future<List<User>> getAllUsers () async {
    users = await userService.getAllUsers();
    return users;
  }

  @override
  initState() {
    super.initState();
    allUsers = getAllUsers();
    print("All Users");
    print(allUsers); 
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    LoginInfoProvider loginInfoProvider =
        Provider.of<LoginInfoProvider>(context);
    var loginInfo = loginInfoProvider.loginInfo;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = loginInfo != null && loginInfo['type'] == "admin" ? size.width / 2: size.width / 1.6;

    return FutureBuilder(
      future:getAllUsers(),
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
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: (itemWidth / itemHeight),),
          itemCount: snapshot.data.length,
          
          itemBuilder: (context, index) {
        UserService userService = UserService();
        return ItemCard(
          image:snapshot.data[index].avatar, 
          title:snapshot.data[index].firstName, 
          edit: () => {
          Navigator.pushNamed(
              context, EditUsersScreen.routeName,
              arguments: UserDetailsArguments(
              user: snapshot.data[index])),
          },
          delete: (){
            showAlertDialog(context,snapshot.data[index].id);
          }
          
        );
        
          }),
        
        
        
      );
             }       }
    );
  }
 showAlertDialog(BuildContext context, id ) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed:  () {
      Navigator.pop(context);
    },
  );
  Widget okButton = TextButton(
    child: Text("Ok"),
    onPressed:  () {
       userService.removeUser(id);
             Navigator.pushNamed(
              context, AllUsersScreen.routeName);
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

