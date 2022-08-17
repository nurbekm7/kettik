import 'package:flutter/material.dart';
import 'package:kettik/components/coustom_bottom_nav_bar.dart';
import 'package:kettik/enums.dart';
import 'package:kettik/constants.dart';

import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: Body(),
        bottomNavigationBar: CustomBottomNavBar(cIndex: 1),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: new FloatingActionButton(
          onPressed: () {
            print("floating ");
          },
          tooltip: 'Increment',
          child: new Icon(Icons.add),
          backgroundColor: kPrimaryBtnColor,
        ));
  }
}
