import 'package:flutter/material.dart';
import 'package:kettik/size_config.dart';
import 'package:kettik/constants.dart';
import 'package:kettik/screens/sign_in/sign_in_screen.dart';
import 'package:get/get.dart';
import '../sign_in/sign_in_binding.dart';
// This is the best practice
import 'components/splash_content.dart';
import '../../../components/default_button.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  static String routeName = "/splash";
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    late List<Map<String, String>> splashData;

    splashData = [
      {"text": 'introTitle1'.tr, "image": "assets/images/splash_1.png"},
      {"text": 'introTitle2'.tr, "image": "assets/images/splash_2.png"},
      {"text": 'introTitle3'.tr, "image": "assets/images/splash_3.png"},
    ];
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
        body: SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3),
                    DefaultButton(
                      text: 'continueText'.tr,
                      press: () async {
                        Get.offAll(SignInScreen(), binding: SignInBinding());
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
