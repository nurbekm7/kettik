import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kettik/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kettik/screens/home/home_screen.dart';
import 'sign_up_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsetsDirectional.only(end: 10),
                  alignment: Alignment.topRight,
                  child: CloseButton(
                    onPressed: () {
                      Get.offAll(HomeScreen());
                    },
                  ),
                ),
                SizedBox(height: _size.height * 0.04), // 4%
                AutoSizeText('register_account'.tr, style: headingStyle),
                AutoSizeText(
                  'register_account_desc'.tr,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: _size.height * 0.08),
                SignUpForm(),
                SizedBox(height: _size.height * 0.08),
                SizedBox(height: 20.h),
                AutoSizeText(
                  '',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
