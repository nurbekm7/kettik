import 'package:flutter/material.dart';
import '../../../size_config.dart';
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
    return Scaffold(
        body: SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Text(
                  'helloWorld'.tr,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Text(
                  'sign_in_body'.tr,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
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
                      SizedBox(height: getProportionateScreenHeight(30)),
                      FormError(errors: errors),
                      SizedBox(height: getProportionateScreenHeight(20)),
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
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SizedBox(height: getProportionateScreenHeight(20))
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
