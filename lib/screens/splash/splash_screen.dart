import 'package:flutter/material.dart';
import 'package:kettik/components/settings_service.dart';
import 'package:kettik/screens/home/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kettik/constants.dart';
import 'package:get/get.dart';
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
    return Scaffold(
        body: SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
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
                padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                        Get.find<SettingsService>().onBoarding();
                        Get.offAll(HomeScreen());
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
