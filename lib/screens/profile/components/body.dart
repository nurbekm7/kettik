import 'package:flutter/material.dart';
import 'package:kettik/components/settings_service.dart';
import 'package:kettik/screens/about/about_screen.dart';
import 'package:kettik/screens/my_ads/my_ads_screen.dart';
import 'package:kettik/screens/sign_in/auth_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';
import 'package:get/get.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "my_transactions".tr,
            icon: "assets/icons/Conversation.svg",
            press: () => {Get.offAll(() => MyAdsScreen())},
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
              Get.find<AuthController>().deleteAccount();
            },
          ),
          ProfileMenu(
            text: "contact_us".tr,
            icon: "assets/icons/Mail.svg",
            press: () {
              launch('https://api.whatsapp.com/send/?phone=+971588050420');
            },
          ),
          ProfileMenu(
            text: "about".tr,
            icon: "assets/icons/Question mark.svg",
            press: () {
              Get.off(() => AboutScreen());
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
}
