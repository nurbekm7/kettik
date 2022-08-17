// import 'package:flutter/material.dart';
// import 'package:kettik/components/default_button.dart';
// import 'package:kettik/models/RequestEntity.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'color_dots.dart';
// import 'product_description.dart';
// import 'top_rounded_container.dart';
// import 'product_images.dart';

// class Body extends StatelessWidget {
//   final Product product;

//   const Body({Key? key, required this.product}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size _size = MediaQuery.of(context).size;

//     return ListView(
//       children: [
//         ProductImages(product: product),
//         TopRoundedContainer(
//           color: Colors.white,
//           child: Column(
//             children: [
//               ProductDescription(
//                 product: product,
//                 pressOnSeeMore: () {},
//               ),
//               TopRoundedContainer(
//                 color: Color(0xFFF6F7F9),
//                 child: Column(
//                   children: [
//                     ColorDots(product: product),
//                     TopRoundedContainer(
//                       color: Colors.white,
//                       child: Padding(
//                         padding: EdgeInsets.only(
//                           left: _size.width * 0.15,
//                           right: _size.height * 0.15,
//                           bottom: 50.h,
//                           top: 15.w,
//                         ),
//                         child: DefaultButton(
//                           text: "Add To Cart",
//                           press: () {},
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
