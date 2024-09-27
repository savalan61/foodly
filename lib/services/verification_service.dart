import 'package:dbestech/controllers/phone_verification_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VerificationService {
  final phoneVerificationCtrl = Get.put(PhoneVerificationController());
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber(String phoneNumber,
      {required Function(String verificationId, int? resendToken) codeSent,
      required Function(FirebaseAuthException e) verificationFailed}) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credentials) async {
          // Automatically sign in the user with the credential if the verification is complete
          try {
            await _auth.signInWithCredential(credentials);
            phoneVerificationCtrl.verifyPhone();
          } catch (e) {
            verificationFailed(e as FirebaseAuthException);
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          // Pass the error to the callback
          verificationFailed(e);
        },
        codeSent: (String verificationId, int? resendToken) {
          // Pass the verificationId and resendToken to the callback
          codeSent(verificationId, resendToken);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle the timeout
          debugPrint("Code auto-retrieval timeout: $verificationId");
        });
  }

  Future<void> verifySmsCode(String verificationId, String smsCode) async {
    try {
      // Create a PhoneAuthCredential with the code
      final credential =
          PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
      // Sign in the user with the credential
      await _auth.signInWithCredential(credential);
      phoneVerificationCtrl.verifyPhone();
    } catch (e) {
      // Handle verification errors
      debugPrint("Verification failed: ${e.toString()}");
    }
  }
}
