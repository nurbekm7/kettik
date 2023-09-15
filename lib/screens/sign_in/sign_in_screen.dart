import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kettik/components/settings_service.dart';
import 'package:kettik/helper/keyboard.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:get/get.dart';
import 'package:kettik/screens/home/home_screen.dart';
import 'auth_controller.dart';
import '../../../components/default_button.dart';
import 'package:kettik/components/global_widgets/loading_overlay.dart';

class SignInScreen extends GetView<AuthController> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditController = TextEditingController();
  String countryIso = 'KZ';
  PhoneNumber number = PhoneNumber(isoCode: 'KZ');
  late Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: LoadingOverlay(
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
            color: Colors.black,
            child: SafeArea(
              bottom: false,
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: Colors.white,
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          padding: const EdgeInsetsDirectional.all(10),
                          alignment: Alignment.topRight,
                          child: CloseButton(
                            onPressed: () {
                              Get.offAll(() => HomeScreen());
                            },
                          ),
                        ),
                        SizedBox(height: _size.height * 0.04),
                        AutoSizeText(
                          'helloWorld'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: _size.height * 0.04),
                        AutoSizeText(
                          'sign_in_body'.tr,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: _size.height * 0.08),
                        Form(
                          key: _formKey,
                          child: Builder(builder: (context) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                InternationalPhoneNumberInput(
                                  locale: Get.find<SettingsService>()
                                      .localeLangCode,
                                  autoFocus: false,
                                  onSubmit: () => _submitedPhoneNumber(),
                                  onInputChanged: (PhoneNumber number) {
                                    countryIso = number.isoCode!;
                                  },
                                  onInputValidated: (bool value) {},
                                  selectorConfig: SelectorConfig(
                                    selectorType:
                                        PhoneInputSelectorType.BOTTOM_SHEET,
                                  ),
                                  ignoreBlank: false,
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  selectorTextStyle:
                                      TextStyle(color: Colors.black),
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
                                SizedBox(height: _size.height * 0.4),
                                DefaultButton(
                                  text: 'continueText'.tr,
                                  press: () {
                                    // if all are valid then go to success screen
                                    KeyboardUtil.hideKeyboard(context);
                                    _submitedPhoneNumber();
                                  },
                                ),
                              ],
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submitedPhoneNumber() async {
    if (_formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      PhoneNumber number = await PhoneNumber.getRegionInfoFromPhoneNumber(
          _textEditController.text, countryIso);
      await controller.submitPhoneNumber(phone: number.phoneNumber!);
    }
  }
}
