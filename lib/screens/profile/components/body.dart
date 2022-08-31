import 'package:flutter/material.dart';

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
            press: () => {},
          ),
          // ProfileMenu(
          //   text: "Notifications",
          //   icon: "assets/icons/Bell.svg",
          //   press: () {},
          // ),
          ProfileMenu(
            text: "delete_account".tr,
            icon: "assets/icons/Trash.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "help".tr,
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "logout".tr,
            icon: "assets/icons/Log out.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}
