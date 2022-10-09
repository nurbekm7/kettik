import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kettik/screens/home/home_screen.dart';
import 'package:kettik/screens/profile/profile_screen.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../enums.dart';

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
  





    // return Container(
    //   padding: EdgeInsets.symmetric(vertical: 14),
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     boxShadow: [
    //       BoxShadow(
    //         offset: Offset(0, -15),
    //         blurRadius: 20,
    //         color: Color(0xFFDADADA).withOpacity(0.15),
    //       ),
    //     ],
    //     borderRadius: BorderRadius.only(
    //       topLeft: Radius.circular(40),
    //       topRight: Radius.circular(40),
    //     ),
    //   ),
    //   child: SafeArea(
    //       top: false,
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
    //         children: [
    //           IconButton(
    //             icon: SvgPicture.asset(
    //               "assets/icons/Shop Icon.svg",
    //               color: MenuState.home == selectedMenu
    //                   ? kPrimaryColor
    //                   : inActiveIconColor,
    //             ),
    //             onPressed: () =>
    //                 Navigator.pushNamed(context, HomeScreen.routeName),
    //           ),
    //           IconButton(
    //             icon: SvgPicture.asset("assets/icons/Heart Icon.svg"),
    //             onPressed: () {},
    //           ),
    //           IconButton(
    //             icon: SvgPicture.asset("assets/icons/Chat bubble Icon.svg"),
    //             onPressed: () {},
    //           ),
    //           IconButton(
    //             icon: SvgPicture.asset(
    //               "assets/icons/User Icon.svg",
    //               color: MenuState.profile == selectedMenu
    //                   ? kPrimaryColor
    //                   : inActiveIconColor,
    //             ),
    //             onPressed: () =>
    //                 Navigator.pushNamed(context, ProfileScreen.routeName),
    //           ),
    //         ],
    //       )),
    // );
//   }
// }
