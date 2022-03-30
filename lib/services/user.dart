import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:saloon_app/models/user.dart';


class UserService {
  CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future<List<User>> getAllUsers() =>
      users.get().then((QuerySnapshot snap) {
        List<User> allUsers = [];
        snap.docs.forEach((snapshot) {
          if (snapshot.exists) {
            allUsers.add(User.fromSnapshot(snapshot));
            log(allUsers.length.toString());
          } else {
            print("Snapshots doesn't exist");
          }
        });

        return allUsers;
      });
  Future<void> addUser(User user) {
    Map<String, dynamic> newUser = {'firstName': user.firstName, 'lastName':user.lastName, 'email':user.email, 'password':user.password, 'phoneNumber':user.phoneNumber, 'address':user.address, 'avatar':user.avatar};
    return users.add(newUser).then((value) {
      print('User ${value.id} added successfully');
    }).catchError((error) => print("Failed to add User: $error"));
  }

    Future<void> updateUser(User user) {
    Map<String, dynamic> updatedUser = {'firstName': user.firstName, 'lastName':user.lastName, 'email':user.email, 'password':user.password, 'phoneNumber':user.phoneNumber, 'address':user.address, 'avatar':user.avatar};
    return users.doc(user.id).update(updatedUser).then((value) {
      print('User ${user.id} updated successfully');
    }).catchError((error) => print("Failed to update User: $error"));
  }

   Future<void> removeUser(String id) {
      return users.doc(id).delete().then((value) {
      print('User ${id} deleted successfully');
    }).catchError((error) => print("Failed to delete User: $error"));
  }

  Future uploadUserImage(File imageFile) async {
    final _firebaseStorage = FirebaseStorage.instance;
    String fileName = basename(imageFile.path);

    try {
      var snapshot = await _firebaseStorage
          .ref()
          .child('uploads/users/${fileName}')
          .putFile(imageFile);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        return downloadUrl;
    } catch (e) {
      print('error occured');
    }
  }
}
