import 'package:firebase_auth/firebase_auth.dart';


class AuthService {
  String _verificationId;
  Future verifyPhone({String phoneNumber , Function whenCodeSent}) async {
    try {
      final PhoneVerificationCompleted verified =
          (AuthCredential authResult) async {
        signIn(authResult).then((user) {
          print('user from signin is $user');
          // if (user != null) success = true;
        });

        print('authResult is $authResult');
      };

      final PhoneVerificationFailed verificationfailed =
          (AuthException authException) {
        print('verificationfailed is $authException');
        print('${authException.message}');
      };

      final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
        _verificationId = verId;
        whenCodeSent();
      };

      final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
        _verificationId = verId;
        print('_verificationId from autoTimeout is $verId');
      };

      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verified,
          verificationFailed: verificationfailed,
          codeSent: smsSent,
          codeAutoRetrievalTimeout: autoTimeout);

    } catch (e) {
      print(e);
    }
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //SignIn
  Future signIn(AuthCredential authCreds) async {
    try {
      final user = await FirebaseAuth.instance.signInWithCredential(authCreds);
      return user;
    } catch (e) {
      print(e);
    }
  }

  Future signInWithOTP(smsCode) async{
    try {
      AuthCredential authCreds = PhoneAuthProvider.getCredential(
          verificationId: _verificationId, smsCode: smsCode);

      print('authCreds providerId is ${authCreds.providerId}');
      print('authCreds hashCode is ${authCreds.hashCode}');

      return await signIn(authCreds);
    } catch (e) {
      print(e);
    }
  }
}
