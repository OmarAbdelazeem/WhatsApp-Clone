
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';

class AuthData extends ChangeNotifier {
  String selectedCountry = 'Choose a country';
  String selectedPhoneCode = '';
  String phoneNumber = '';
  bool isVerified = false;
  String userId = '';
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

}

