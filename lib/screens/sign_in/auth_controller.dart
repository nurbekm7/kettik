import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kettik/components/settings_service.dart';
import 'package:kettik/models/UserProfile.dart';
import 'package:kettik/screens/home/home_screen.dart';
import 'package:kettik/screens/sign_up/sign_up_screen.dart';
import '../otp/otp_screen.dart';
import 'dart:developer' as debug;

class AuthController extends GetxController {
  bool showLoadingOverlay = false;
  String _phoneNumber = '';
  late AuthCredential _phoneAuthCredential;
  String? _verificationId = '';
  User? _firebaseUser;
  UserProfile? userProfile;

  String getPhoneNumber() {
    return _phoneNumber;
  }

  Future<void> submitPhoneNumber({required String phone}) async {
    print("submitPhoneNumber: $phone");
    showLoadingOverlay = true;
    update();
    _phoneNumber = phone;
    try {
      void verificationCompleted(AuthCredential phoneAuthCredential) {
        _phoneAuthCredential = phoneAuthCredential;
      }

      void verificationFailed(FirebaseAuthException e) {
        print(e);
        if (e.code == 'too-many-requests') {
          showLoadingOverlay = false;
          update();
          Fluttertoast.showToast(
              msg: 'too many requests, pelase try again later');
        }
      }

      void codeSent(String verificationId, [int? code]) {
        _verificationId = verificationId;
        showLoadingOverlay = false;
        update();
        Get.to(() => OtpScreen());
      }

      void codeAutoRetrievalTimeout(String verificationId) {
        _verificationId = verificationId;
      }

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: _phoneNumber,
        timeout: Duration(milliseconds: 10000),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        //both are called based on diff conditions, not tested both
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } on FirebaseAuthException catch (e) {
      showLoadingOverlay = false;
      update();
      print('Failed with error code: ${e.code}');
      print(e.message);
      print(e.code);
    } catch (e) {
      showLoadingOverlay = false;
      update();
      print('Unknown Firebase Auth error: ${e.toString()}');
    }
  }

  void submitOTP({required String otp}) async {
    showLoadingOverlay = true;

    update();
    _phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId ?? '', smsCode: otp.trim());
    try {
      await FirebaseAuth.instance
          .signInWithCredential(_phoneAuthCredential)
          .then((authRes) async {
        _firebaseUser = authRes.user!;
        print(_firebaseUser);

        userProfile = UserProfile(
            id: _firebaseUser!.uid,
            name: _firebaseUser!.displayName,
            phoneNumber: _firebaseUser!.phoneNumber!,
            photoURL: _firebaseUser!.photoURL);

        if (userProfile!.name == null) {
          debug.log('userProfile!.name == null: $userProfile');
          //DO SIGN_UP
          showLoadingOverlay = false;
          Get.off(SignUpScreen());
        } else {
          //DO SIGN_IN
          showLoadingOverlay = false;
          Get.find<SettingsService>().login(userProfileParam: userProfile);
          Get.offAll(() => HomeScreen());
        }
      }).catchError((e) {
        print(e);
        showLoadingOverlay = false;
        update();
        if (e.code == 'invalid-verification-code') {
          Fluttertoast.showToast(msg: 'invalid_otp'.tr);
        }
      });
    } catch (e) {
      print(e);
      // Get.find<SettingsService>().logout();
    }
  }

  void signUp(String name) async {
    await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
    userProfile = UserProfile(
        id: _firebaseUser!.uid,
        name: name,
        phoneNumber: _firebaseUser!.phoneNumber!,
        photoURL: _firebaseUser!.photoURL);
    Get.find<SettingsService>().signUp(userProfileParam: userProfile);
    Get.off(() => HomeScreen());
  }
}
