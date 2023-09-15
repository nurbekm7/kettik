import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kettik/components/coustom_bottom_nav_bar.dart';
import 'package:kettik/constants.dart';
import 'package:kettik/models/RequestEntity.dart';
import 'package:kettik/screens/sign_in/sign_in_screen.dart';
import 'package:kettik/screens/transaction/create_request_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/scheduler.dart';
import 'package:kettik/components/settings_service.dart';

import 'components/body.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => new ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    print(
        "ProfileScreenState onInit: ${Get.find<SettingsService>().isLoggedIn}");
    if (!Get.find<SettingsService>().isLoggedIn) {
      _openSignInDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: AutoSizeText(Get.find<SettingsService>().userProfile!.name!),
            backgroundColor: kPrimaryColor,
          ),
          body: Body(),
          bottomNavigationBar: CustomBottomNavBar(cIndex: 1),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: new FloatingActionButton(
            onPressed: () {
              _openAddTransDialog();
            },
            tooltip: 'Add',
            child: new Icon(Icons.add),
            backgroundColor: kPrimaryBtnColor,
          )),
    );
  }

  Future _openAddTransDialog() async {
    Get.to(() => CreateRequestScreen());
  }

  Future _openSignInDialog() async {
    Get.to(() => SignInScreen());
  }
}
