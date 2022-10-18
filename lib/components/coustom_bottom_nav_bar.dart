import 'package:flutter/material.dart';
import 'package:kettik/screens/home/home_screen.dart';
import 'package:kettik/screens/profile/profile_screen.dart';
import 'package:get/get.dart';

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
          Get.off(() => HomeScreen());

          break;
        case 1:
          print('1: ' + index.toString());
          Get.off(() => ProfileScreen());
          break;
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
}
