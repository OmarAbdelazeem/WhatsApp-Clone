import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../services/auth_service.dart';

class Data extends ChangeNotifier {
  String selectedCountry = 'Choose a country';
  String selectedPhoneCode = '';
  String phoneNumber = '';
  // String verificationId = '';
  bool isVerified = false;
  String userName = '';
  // FirebaseAuth _auth;
  FirebaseUser _loggedInUser;
  String senderId = '';
  bool codeSent = false;
  AuthService _authService = AuthService();

  void onCountrySelected(String name, String phoneCode) {
    selectedCountry = name;
    selectedPhoneCode = phoneCode;
    notifyListeners();
  }

  void onPhoneChanged(String phone) {
    phoneNumber = phone;
    notifyListeners();
  }

  void onNameChanged(String name) {
    userName = name;
    notifyListeners();
  }

  void signWithOtp(String smsCode) {
    _authService.signInWithOTP(smsCode).then(
      (user) async {
        if (user != null) {
          isVerified = true;
          print('isVerified is $isVerified');
          _loggedInUser = await FirebaseAuth.instance.currentUser();
          senderId = _loggedInUser.uid;
          notifyListeners();
        }
      },
    );
  }

  verifyPhone() {
    String number = '+' + selectedPhoneCode + phoneNumber;
    _authService.verifyPhone(phoneNumber: number,whenCodeSent: _whenCodeSent);
  }

  void _whenCodeSent() {
    codeSent = true;
    notifyListeners();
  }

  Future setUpUser() async {
    var usersRef = Firestore.instance.collection('users');
    bool founded = false;
    try {
      List<DocumentSnapshot> usersDocumentSnapshot;
      usersRef.getDocuments().then((documents) async {
        usersDocumentSnapshot = documents.documents;
        for (var i = 0; i < usersDocumentSnapshot.length; i++) {
          print('doc $i is ${usersDocumentSnapshot[i].documentID}');

          if (usersDocumentSnapshot[i].documentID == senderId) {
            founded = true;
            break;
          }
        }
        if (!founded) {
          DocumentReference documentReference = usersRef.document(senderId);

          Map<String, dynamic> userData = {
            'myId': senderId,
            'name': userName,
            'userChats': [],
            'status': '',
            'phoneNumber': phoneNumber,
            'profilePhoto': ''
          };
          await documentReference.setData(userData);
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
