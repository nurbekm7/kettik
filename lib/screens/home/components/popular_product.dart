// import 'package:flutter/material.dart';
// import 'package:kettik/components/product_card.dart';
// import 'package:kettik/models/RequestEntity.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'section_title.dart';

// class PopularProducts extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20.w),
//           child: SectionTitle(title: "Popular Products", press: () {}),
//         ),
//         SizedBox(height: 20.h),
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: [
//               ...List.generate(
//                 demoProducts.length,
//                 (index) {
//                   if (demoProducts[index].isPopular)
//                     return ProductCard(product: demoProducts[index]);

//                   return SizedBox
//                       .shrink(); // here by default width and height is 0
//                 },
//               ),
//               SizedBox(width: 20.w),
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }
