import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kettik/components/coustom_bottom_nav_bar.dart';
import 'package:kettik/constants.dart';
import 'package:kettik/models/RequestEntity.dart';
import 'package:kettik/screens/profile/profile_screen.dart';
import 'package:kettik/screens/sign_in/sign_in_screen.dart';
import 'package:kettik/screens/transaction/create_request_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/scheduler.dart';
import 'package:kettik/components/settings_service.dart';

import 'components/body.dart';

class AboutScreen extends StatefulWidget {
  AboutScreen({Key? key}) : super(key: key);

  @override
  AboutScreenState createState() => new AboutScreenState();
}

class AboutScreenState extends State<AboutScreen> {
  @override
  void initState() {
    super.initState();
    print("AboutScreenState onInit: ${Get.find<SettingsService>().isLoggedIn}");
    if (!Get.find<SettingsService>().isLoggedIn) {
      _openSignInDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.offAll(() => ProfileScreen()),
          ),
          title: AutoSizeText("about".tr),
          backgroundColor: kPrimaryColor,
        ),
        body: Body(),
        bottomNavigationBar: CustomBottomNavBar(cIndex: 1),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: new FloatingActionButton(
          onPressed: () {
            _openAddTransDialog();
          },
          tooltip: 'Add',
          child: new Icon(Icons.add),
          backgroundColor: kPrimaryBtnColor,
        ));
  }

  Future _openAddTransDialog() async {
    RequestEntity? requestEntity =
        await Navigator.of(context).push(new MaterialPageRoute<RequestEntity>(
            builder: (BuildContext context) {
              return new CreateRequestScreen();
            },
            fullscreenDialog: true));
    print(requestEntity);
    if (requestEntity != null) {
      print("requestEntity: ${requestEntity.id}");
      setState(() {
        // requestEntityList.add(requestEntity);
      });
    }
  }

  Future _openSignInDialog() async {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.of(context).push(MaterialPageRoute<String>(
          builder: (BuildContext context) {
            return SignInScreen();
          },
          fullscreenDialog: true));

      setState(() {});
    });
  }
}
