// import 'package:flutter/material.dart';
// import 'package:kettik/screens/cart/cart_screen.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'icon_btn_with_counter.dart';
// import 'search_field.dart';

// class HomeHeader extends StatelessWidget {
//   const HomeHeader({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20.w),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           SearchField(),
//           IconBtnWithCounter(
//             svgSrc: "assets/icons/Cart Icon.svg", //todo filter and sort
//             press: () => Navigator.pushNamed(context, CartScreen.routeName),
//           ),
//           IconBtnWithCounter(
//             svgSrc: "assets/icons/Bell.svg",
//             numOfitem: 3,
//             press: () {},
//           ),
//         ],
//       ),
//     );
//   }
// }
