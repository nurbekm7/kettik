import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Spacer(),
        Text(
          "KETTIK",
          style: TextStyle(
            fontSize: 36.w,
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Text(text!,
            textAlign: TextAlign.center, style: TextStyle(fontSize: 16.w)),
        Spacer(flex: 1),
        Image.asset(
          image!,
          height: 265.h,
          width: 235.w,
        ),
      ],
    );
  }
}
