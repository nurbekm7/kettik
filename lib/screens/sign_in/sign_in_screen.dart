import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kettik/components/form_error.dart';
import 'package:kettik/helper/keyboard.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:get/get.dart';
import 'sign_in_controller.dart';
import '../../../components/default_button.dart';

class SignInScreen extends GetView<AuthController> {
  static String routeName = "/sign_in";
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditController = TextEditingController();
  String countryIso = 'AE';
  PhoneNumber number = PhoneNumber(isoCode: 'AE');
  final List<String?> errors = [];

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: _size.height * 0.04),
                Text(
                  'helloWorld'.tr,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: _size.height * 0.04),
                Text(
                  'sign_in_body'.tr,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: _size.height * 0.08),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InternationalPhoneNumberInput(
                        autoFocus: false,
                        onSubmit: () => _submitePhoneNumber(),
                        onInputChanged: (PhoneNumber number) {
                          countryIso = number.isoCode!;
                        },
                        onInputValidated: (bool value) {},
                        selectorConfig: SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        ),
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        selectorTextStyle: TextStyle(color: Colors.black),
                        initialValue: number,
                        textFieldController: _textEditController,
                        formatInput: false,
                        keyboardType: TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        inputDecoration: InputDecoration.collapsed(
                            hintText: 'phonePrompt'.tr),
                        onSaved: (PhoneNumber number) {
                          countryIso = number.isoCode!;
                        },
                      ),
                      SizedBox(height: 30.h),
                      FormError(errors: errors),
                      SizedBox(height: 20.h),
                      DefaultButton(
                        text: 'continueText'.tr,
                        press: () {
                          // if all are valid then go to success screen
                          KeyboardUtil.hideKeyboard(context);
                          _submitePhoneNumber();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: _size.height * 0.08),
                SizedBox(height: 20.h)
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Future<void> _submitePhoneNumber() async {
    if (_formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      PhoneNumber number = await PhoneNumber.getRegionInfoFromPhoneNumber(
          _textEditController.text, countryIso);
      await controller.submitPhoneNumber(phone: number.toString());
    }
  }
}
