// import 'package:flutter/material.dart';
// import 'package:kettik/models/RequestEntity.dart';

// import '../../../constants.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ProductImages extends StatefulWidget {
//   const ProductImages({
//     Key? key,
//     required this.product,
//   }) : super(key: key);

//   final Product product;

//   @override
//   _ProductImagesState createState() => _ProductImagesState();
// }

// class _ProductImagesState extends State<ProductImages> {
//   int selectedImage = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           width: 238.w,
//           child: AspectRatio(
//             aspectRatio: 1,
//             child: Hero(
//               tag: widget.product.id.toString(),
//               child: Image.asset(widget.product.images[selectedImage]),
//             ),
//           ),
//         ),
//         // SizedBox(height: 20.w),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ...List.generate(widget.product.images.length,
//                 (index) => buildSmallProductPreview(index)),
//           ],
//         )
//       ],
//     );
//   }

//   GestureDetector buildSmallProductPreview(int index) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedImage = index;
//         });
//       },
//       child: AnimatedContainer(
//         duration: defaultDuration,
//         margin: EdgeInsets.only(right: 15),
//         padding: EdgeInsets.all(8),
//         height: 48.w,
//         width: 48.w,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//               color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
//         ),
//         child: Image.asset(widget.product.images[index]),
//       ),
//     );
//   }
// }
