import 'package:flutter/material.dart';
import 'package:kettik/components/default_button.dart';
import 'package:kettik/screens/home/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(height: _size.height * 0.04),
        Image.asset(
          "assets/images/success.png",
          height: _size.height * 0.4, //40%
        ),
        SizedBox(height: _size.height * 0.08),
        Text(
          "Login Success",
          style: TextStyle(
            fontSize: 30.w,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Spacer(),
        SizedBox(
          width: _size.width * 0.6,
          child: DefaultButton(
            text: "Back to home",
            press: () {
              // Navigator.pushNamed(context, HomeScreen.routeName);
            },
          ),
        ),
        Spacer(),
      ],
    );
  }
}
