import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kettik/components/analytics_controller.dart';
import 'package:kettik/components/connectivity_controller.dart';
import 'package:kettik/components/languages.dart';
import 'package:kettik/components/settings_service.dart';
import 'package:kettik/dependency_injection.dart';
import 'package:kettik/routes.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get_storage/get_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart'; //for date format

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  late GetStorage _getStorage = GetStorage();
  Intl.defaultLocale =
      WidgetsBinding.instance.window.locales.first.toString(); //sets global,

  await ScreenUtil.ensureScreenSize();

  runApp(DevicePreview(
    enabled: false,
    builder: (context) => ScreenUtilInit(
      designSize: const Size(412, 732),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          builder: DevicePreview.appBuilder,
          translations: Languages(),
          locale: Get.find<SettingsService>().locale,
          localizationsDelegates: [GlobalMaterialLocalizations.delegate],
          fallbackLocale: WidgetsBinding.instance.window.locales.first,
          title: "KETTIK",
          initialRoute: Get.find<SettingsService>().firstRun
              ? AppPages.INITIAL
              : AppPages.HOME,
          navigatorObservers: <NavigatorObserver>[
            Get.find<AnalyticsService>().observer
          ],
          debugShowCheckedModeBanner: false,
          initialBinding: DependencyInjection(),
          theme: ThemeData(fontFamily: 'Muli'),
          getPages: AppPages.routes,
        );
      },
    ),
  ));
}

Future<void> initServices() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    //track during development
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    await GetStorage.init();
    await Get.putAsync<AnalyticsService>(() async => AnalyticsService());
    await Get.putAsync<SettingsService>(() async => SettingsService());
    await Get.find<SettingsService>().initSharedPrefs();
    final controller =
        Get.put<ConnectivityController>(ConnectivityController());
    controller.initCheckConnectivity();
  } catch (e) {
    print("Failed to initServices: $e");
    Fluttertoast.showToast(msg: 'Please check internet connection');
  }
}
