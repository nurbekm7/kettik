import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kettik/components/custom_surfix_icon.dart';
import 'package:kettik/components/default_button.dart';
import 'package:kettik/components/form_error.dart';
import 'package:kettik/components/settings_service.dart';
import 'package:get/get.dart';
import 'package:kettik/screens/sign_in/auth_controller.dart';
import 'dart:developer' as debug;

import '../../../constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? name;

  bool remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AutoSizeText(
              'name_label'.tr,
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildFirstNameFormField(),
          ),
          FormError(errors: errors),
          SizedBox(height: 40.h),
          AutoSizeText(
            "terms_and_condition".tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption,
          ),
          SizedBox(height: 40.h),
          DefaultButton(
            text: "continue".tr,
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                debug.log('User input name: $name');
                Get.find<AuthController>().signUp(name!);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => name = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
          name = value;
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: kLightGrey),
        ),
        filled: true,
        fillColor: kLightGrey,
        hintText: "name_hint".tr,
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  // TextFormField buildEmailFormField() {
  //   return TextFormField(
  //     keyboardType: TextInputType.emailAddress,
  //     onSaved: (newValue) => email = newValue,
  //     onChanged: (value) {
  //       if (value.isNotEmpty) {
  //         removeError(error: kEmailNullError);
  //       } else if (emailValidatorRegExp.hasMatch(value)) {
  //         removeError(error: kInvalidEmailError);
  //       }
  //       return null;
  //     },
  //     validator: (value) {
  //       if (value!.isEmpty) {
  //         addError(error: kEmailNullError);
  //         return "";
  //       } else if (!emailValidatorRegExp.hasMatch(value)) {
  //         addError(error: kInvalidEmailError);
  //         return "";
  //       }
  //       return null;
  //     },
  //     decoration: InputDecoration(
  //       labelText: "Email",
  //       hintText: "Enter your email",
  //       // If  you are using latest version of flutter then lable text and hint text shown like this
  //       // if you r using flutter less then 1.20.* then maybe this is not working properly
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //       suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
  //     ),
  //   );
  // }
}
