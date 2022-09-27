import 'package:flutter/material.dart';
import 'package:kettik/components/global_widgets/loading_overlay.dart';
import 'package:kettik/screens/sign_in/auth_controller.dart';
import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../components/default_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/body.dart';

class OtpScreen extends GetView<AuthController> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  late Size _size;
  final _formKey = GlobalKey<FormState>();
  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return LoadingOverlay(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
          color: Colors.black,
          child: SafeArea(
            bottom: false,
            child: Scaffold(
                // appBar: AppBar(
                //   systemOverlayStyle: SystemUiOverlayStyle(
                //     statusBarColor: Colors.black,
                //   ),
                //   backgroundColor: Colors.black,
                //   title: AutoSizeText(
                //     'phone_verification'.tr,
                //     style: TextStyle(
                //         color: Colors.white,
                //         fontWeight: FontWeight.w600,
                //         fontSize: 18.sp),
                //   ),
                //   centerTitle: true,
                //   automaticallyImplyLeading: false,
                // ),
                backgroundColor: Colors.white,
                resizeToAvoidBottomInset: true,
                body: Form(
                  key: _formKey,
                  child: Builder(
                    builder: (context) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 24.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 36.0.h),
                                      child: Text(
                                        'we_have_sent_code'.tr +
                                            controller.getPhoneNumber(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 24.sp),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 16.0.w, bottom: 8.h),
                                      child: Text(
                                        'enter_code_below'.tr,
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.only(
                                          left: 16.0.w, right: 16.w),
                                      child: PinPut(
                                        fieldsCount: 6,
                                        onSubmit: (String pin) {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            controller.submitOTP(otp: pin);
                                          }
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'This field is required';
                                          }
                                          return null;
                                        },
                                        focusNode: _pinPutFocusNode,
                                        autofocus: true,
                                        controller: _pinPutController,
                                        submittedFieldDecoration:
                                            _pinPutDecoration.copyWith(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        selectedFieldDecoration:
                                            _pinPutDecoration,
                                        followingFieldDecoration:
                                            _pinPutDecoration.copyWith(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    // Spacer(flex: 3),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Column(
                                          children: [
                                            DefaultButton(
                                              text: 'continueText'.tr,
                                              press: () async {
                                                controller.submitOTP(
                                                    otp:
                                                        _pinPutController.text);
                                              },
                                            ),

                                            // Container(
                                            //   margin: EdgeInsets.all(0),
                                            //   width: double.infinity,
                                            //   child: ElevatedButton(
                                            //     style: ElevatedButton.styleFrom(
                                            //       minimumSize:
                                            //           Size(_size.width, 50.h),
                                            //       primary: kPrimaryColor,
                                            //       shape: RoundedRectangleBorder(
                                            //           borderRadius:
                                            //               BorderRadius.circular(
                                            //                   6)),
                                            //     ),
                                            //     onPressed: () async {
                                            //       controller.submitOTP(
                                            //           otp: _pinPutController
                                            //               .text);
                                            //     },
                                            //     child: Text(
                                            //       'next'.tr,
                                            //       style: TextStyle(
                                            //           color: Colors.white,
                                            //           fontSize: 16.sp),
                                            //     ),
                                            //   ),
                                            // ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Opacity(
                                              opacity: 1.0,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text('did_not_get_the_code'
                                                      .tr),
                                                  Text(
                                                    'resend'.tr,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
