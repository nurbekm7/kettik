import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kettik/screens/home/home_screen.dart';
import '../otp/otp_screen.dart';

class FilterController extends GetxController {
  bool showLoadingOverlay = false;
  late String _phoneNumber;
  late AuthCredential _phoneAuthCredential;
  String? _verificationId = '';
  late User _firebaseUser;

  Future<void> submitPhoneNumber({required String phone}) async {
    print("submitPhoneNumber: $phone");
    showLoadingOverlay = true;
    update();
    _phoneNumber = phone;
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

    try {
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
        Get.offAll(HomeScreen());
        // final _usersCollection = _firestore.collection('users');
        // _usersCollection.where("phone", isEqualTo: _phoneNumber).get().then(
        //     (value) {
        //   print("check phone number in firestore: ${value.docs.length}");
        //   if (value.docs.isEmpty) {

        //   } else {

        //   }

        // }, onError: (e) => print("Couldn't find phone: $e"));
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
}
