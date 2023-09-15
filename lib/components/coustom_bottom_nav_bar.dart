import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:kettik/components/settings_service.dart';
import 'package:kettik/screens/home/home_screen.dart';
import 'package:kettik/screens/profile/profile_screen.dart';
import 'package:get/get.dart';
import 'package:kettik/screens/sign_in/sign_in_screen.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({Key? key, required this.cIndex}) : super(key: key);
  final int cIndex;

  @override
  _CustomBottomNavBarState createState() =>
      new _CustomBottomNavBarState(pIndex: cIndex);
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int pIndex;
  _CustomBottomNavBarState({required this.pIndex});
  void _incrementTab(index) {
    setState(() {
      pIndex = index;
      switch (pIndex) {
        case 0:
          print('0: ' + index.toString());
          Get.offAll(() => HomeScreen());
          break;
        case 1:
          if (!Get.find<SettingsService>().isLoggedIn) {
            _openSignInDialog();
            break;
          } else {
            print('1: ' + index.toString());
            Get.offAll(() => ProfileScreen());
            break;
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('_cIndex: $pIndex');
    return BottomNavigationBar(
      currentIndex: pIndex,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color.fromARGB(255, 0, 0, 0)),
            label: 'home'.tr),
        BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Color.fromARGB(255, 0, 0, 0)),
            label: 'profile'.tr)
      ],
      onTap: (index) {
        _incrementTab(index);
      },
    );
  }

  Future _openSignInDialog() async {
    Get.to(() => SignInScreen());
  }
}
