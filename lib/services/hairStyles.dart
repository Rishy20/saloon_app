import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:saloon_app/models/hairStyles.dart';

class HairStylesService {
  CollectionReference hairstyles =
      FirebaseFirestore.instance.collection('hairstyles');

  Future<List<HairStyles>> getAllHairStyles() =>
      hairstyles.get().then((QuerySnapshot snap) {
        List<HairStyles> getAllHairStyles = [];
        snap.docs.forEach((snapshot) {
          if (snapshot.exists) {
            getAllHairStyles.add(HairStyles.fromSnapshot(snapshot));
          } else {
            print("Snapshots doesn't exist");
          }
        });

        return getAllHairStyles;
      });
  Future<void> addHairStyle(HairStyles hs) {
    Map<String, dynamic> hairstyle = {
      'style': hs.style,
      'image': hs.image,
      'description': hs.description,
      'gender':hs.gender
    };
    return hairstyles.add(hairstyle).then((value) {
      print('Hair Styles ${value.id} added successfully');
    }).catchError((error) => print("Failed to add Hair Styles: $error"));
  }

  Future<void> updateHairStyle(HairStyles hs) {
    Map<String, dynamic> hairstyle = {
      'style': hs.style,
      'image': hs.image,
      'description': hs.description,
      'gender':hs.gender
    };
    return hairstyles.doc(hs.id).update(hairstyle).then((value) {
      print('Hair Styles ${hs.id} updated successfully');
    }).catchError((error) => print("Failed to update Hair Styles: $error"));
  }

  Future<void> removeHairStyles(String id) {
    return hairstyles.doc(id).delete().then((value) {
      print('Hair Style ${id} deleted successfully');
    }).catchError((error) => print("Failed to delete Hair Styles: $error"));
  }

  Future uploadHairStylesImage(File imageFile) async {
    final _firebaseStorage = FirebaseStorage.instance;
    String fileName = basename(imageFile.path);

    try {
      var snapshot = await _firebaseStorage
          .ref()
          .child('uploads/hairstyles/${fileName}')
          .putFile(imageFile);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('error occured');
    }
  }
  Future<int> getHairStylesCount() =>
      hairstyles.get().then((QuerySnapshot snap) {
        return snap.docs.length;
      });
}
