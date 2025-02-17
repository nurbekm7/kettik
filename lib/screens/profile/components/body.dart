import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kettik/components/settings_service.dart';
import 'package:kettik/screens/about/about_screen.dart';
import 'package:kettik/screens/my_ads/my_ads_screen.dart';
import 'package:kettik/screens/sign_in/auth_controller.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          SizedBox(height: 20),
          AutoSizeText(
            Get.find<SettingsService>().userProfile!.phoneNumber,
            style: TextStyle(fontSize: 16.sp),
          ),
          SizedBox(height: 20),
          ProfileMenu(
            text: "my_transactions".tr,
            icon: "assets/icons/Conversation.svg",
            press: () => {Get.to(() => MyAdsScreen())},
          ),
          // ProfileMenu(
          //   text: "Notifications",
          //   icon: "assets/icons/Bell.svg",
          //   press: () {},
          // ),
          ProfileMenu(
            text: "delete_account".tr,
            icon: "assets/icons/Trash.svg",
            press: () {
              showAlertDialog(context);
            },
          ),
          ProfileMenu(
            text: "contact_us".tr,
            icon: "assets/icons/Mail.svg",
            press: () {
              launchUrlString('https://www.instagram.com/bekofdevs/',
                  mode: LaunchMode.externalApplication);
            },
          ),
          ProfileMenu(
            text: "about".tr,
            icon: "assets/icons/Question mark.svg",
            press: () {
              Get.to(() => AboutScreen());
            },
          ),
          ProfileMenu(
            text: "logout".tr,
            icon: "assets/icons/Log out.svg",
            press: () {
              Get.find<SettingsService>().logout();
            },
          ),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("no".tr),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("yes".tr),
      onPressed: () {
        Get.find<AuthController>().deleteAccount();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("account_delete_title".tr),
      content: Text("account_delete_body".tr),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
