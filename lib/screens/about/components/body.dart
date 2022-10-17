import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
              launch(
                  'https://www.termsandconditionsgenerator.com/live.php?token=moY0HzjsVNOJLINwa46WCvMjSYOdTOJb');
            },
          ),
          ProfileMenu(
            text: "privacy_policy".tr,
            icon: "assets/icons/Bill Icon.svg",
            press: () {
              launch(
                  'https://www.privacypolicygenerator.info/live.php?token=N1IEQ1kA2I1dcFT94EIQsKQMU009Kowz');
            },
          )
        ],
      ),
    );
  }
}
