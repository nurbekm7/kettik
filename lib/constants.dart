import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

const kPrimaryColor = Color(0xff5a4d94);
const kPrimaryLightColor = Color.fromARGB(255, 89, 81, 122);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Colors.black;
const kTabColor = Color.fromARGB(15, 31, 16, 128);
const kLightGrey = Color(0xfff1f3f5);
const kAnimationDuration = Duration(milliseconds: 200);
const kPrimaryBtnColor = Color(0xfff79932);

final headingStyle = TextStyle(
  fontSize: 28.h,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
String kWrongRequestType = "kWrongRequestType".tr;
String kNullCountryField = "kNullCountryField".tr;
String kNullRegionField = "kNullRegionField".tr;
String kNullCityField = "kNullCityField".tr;
String kNullToCountryField = "kNullToCountryField".tr;
String kNullToRegionField = "kNullToRegionField".tr;
String kNullToCityField = "kNullToCityField".tr;
String kNullWeightField = "kNullWeightField".tr;
String kNullPriceField = "kNullPriceField".tr;
String kNullNoteField = "kNullNoteField".tr;

final otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 15.h),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.w),
    borderSide: BorderSide(color: kTextColor),
  );
}
