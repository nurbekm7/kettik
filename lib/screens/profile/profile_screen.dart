import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kettik/components/coustom_bottom_nav_bar.dart';
import 'package:kettik/enums.dart';
import 'package:kettik/constants.dart';
import 'package:kettik/models/RequestEntity.dart';
import 'package:kettik/screens/transaction/create_request_screen.dart';
import 'package:get/get.dart';

import 'components/body.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => new ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: AutoSizeText("profile".tr),
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
}
