import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapptest/models/user.dart';
import 'package:whatsapptest/services/data_base_service.dart';
import '../services/auth_service.dart';

class AuthData extends ChangeNotifier {
  String selectedCountry = 'Choose a country';
  String selectedPhoneCode = '';
  String phoneNumber = '';
  bool isVerified = false;
//  String userName = '';
  String userId = '';
  bool codeSent = false;
//  File profilePhoto ;
//  String photoUrl;
//  String profilePhotoUrl;
  AuthService _authService = AuthService();
//  DataBaseService _dataBaseService = DataBaseService();
//  User defaultUser;

  void onCountrySelected(String name, String phoneCode) {
    selectedCountry = name;
    selectedPhoneCode = phoneCode;
    notifyListeners();
  }

  void onPhoneChanged(String phone) {
    phoneNumber = phone;
    notifyListeners();
  }

//  void onNameChanged(String name) {
//    userName = name;
//  }

  Future signWithOtp(String smsCode) async{
      final user = await _authService.signInWithOTP(smsCode);
      if (user != null) {
        isVerified = true;
        print('isVerified is $isVerified');
        FirebaseUser _loggedInUser = await FirebaseAuth.instance.currentUser();
        userId = _loggedInUser.uid;
        notifyListeners();
      }
      return user;
  }

  verifyPhone() {
    void _whenCodeSent() {
      codeSent = true;
      notifyListeners();
    }
    String number = '+' + selectedPhoneCode + phoneNumber;
    _authService.verifyPhone(phoneNumber: number, whenCodeSent: _whenCodeSent);
  }

//  Future setUpUser() async{
//
//    if (profilePhoto != null) {
//      photoUrl = await  _dataBaseService.uploadFile(selectedFile: profilePhoto);
//    }
//    return _dataBaseService.setUpUser(
//        userName: userName, phoneNumber: phoneNumber, senderId: senderId,photoUrl: photoUrl);
//  }
//
//  handleImage(ImageSource source) async {
//      profilePhoto = await _dataBaseService.getImage(source);
//        notifyListeners();
//      print('_selectedFile is $profilePhoto');
//  }
}
