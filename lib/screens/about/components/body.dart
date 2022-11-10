import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'profile_menu.dart';
import 'package:get/get.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfileMenu(
            text: "terms".tr,
            icon: "assets/icons/receipt.svg",
            press: () {
              launchUrlString(
                  'https://firebasestorage.googleapis.com/v0/b/kettik-19d03.appspot.com/o/index.html?alt=media&token=70a375ce-a4d5-4b50-a46e-89abd52d5522');
            },
          ),
          ProfileMenu(
            text: "privacy_policy".tr,
            icon: "assets/icons/Bill Icon.svg",
            press: () {
              launchUrlString(
                  'https://firebasestorage.googleapis.com/v0/b/kettik-19d03.appspot.com/o/index.html?alt=media&token=70a375ce-a4d5-4b50-a46e-89abd52d5522');
            },
          )
        ],
      ),
    );
  }
}
