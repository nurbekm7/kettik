import 'package:kettik/screens/home/home_screen.dart';
import 'package:kettik/screens/otp/otp_screen.dart';
import 'package:kettik/screens/sign_in/sign_in_binding.dart';
import 'package:kettik/screens/sign_in/sign_in_screen.dart';

import 'package:get/get.dart';
import 'package:kettik/screens/splash/splash_screen.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;
  static const HOME = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeScreen(),
      // binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => SignInScreen(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => OtpScreen(),
      // binding: ReportBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashScreen(),
      // binding: SplashBinding(),
    ),
  ];
}

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const SIGN_IN = _Paths.SIGN_IN;
  static const OTP = _Paths.OTP;
  static const SPLASH = _Paths.SPLASH;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const SIGN_IN = '/sign_in';
  static const OTP = '/otp';
  static const SPLASH = '/splash';
}
