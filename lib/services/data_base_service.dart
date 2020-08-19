import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class DataBaseService {
  var _usersRef = Firestore.instance.collection('users');


  Future setUpUser(
      {@required String userId,
      @required String userName,
      @required String phoneNumber,
       String photoUrl = ''}) async {
    bool founded = false;
    try {
      List<DocumentSnapshot> usersDocumentSnapshot;
      _usersRef.getDocuments().then((documents) async {
        usersDocumentSnapshot = documents.documents;
        for (var i = 0; i < usersDocumentSnapshot.length; i++) {
          print('doc $i is ${usersDocumentSnapshot[i].documentID}');

          if (usersDocumentSnapshot[i].documentID == userId) {
            founded = true;
            break;
          }
        }
        if (!founded) {
          DocumentReference documentReference = _usersRef.document(userId);


          Map<String, dynamic> userData = {
            'myId': userId,
            'name': userName,
            'userChats': [],
            'status': '',
            'phoneNumber': phoneNumber,
            'profilePhoto': photoUrl
          };
          await documentReference.setData(userData);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future getImage(ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);
    if (image != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.deepOrange,
            toolbarTitle: "RPS Cropper",
            statusBarColor: Colors.deepOrange.shade900,
            backgroundColor: Colors.white,
          ));
      return cropped;
    }
  }

  Future uploadFile({@required File selectedFile}) async {
    String folder = 'profilePhotos';

    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('$folder/${Path.basename(selectedFile.path)}}');

    StorageUploadTask uploadTask = storageReference.putFile(selectedFile);
    await uploadTask.onComplete;
    final fileURL = await storageReference.getDownloadURL();
    return fileURL;
  }

  Future setPhotoData({String fileURL, String userId}) async {
    await _usersRef.document(userId).updateData({
      'photoUrl': fileURL,
    });
  }
}
