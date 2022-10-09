import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kettik/components/analytics_controller.dart';
import 'package:kettik/models/UserProfile.dart';
import 'package:kettik/screens/home/home_screen.dart';
import 'dart:developer' as debug;

class SettingsService extends GetxService {
  late GetStorage _getStorage = GetStorage();
  late bool firstRun = true;
  late String localeLangCode = '';
  Locale locale = WidgetsBinding.instance.window.locales.first;
  late bool isLoggedIn = false;
  UserProfile? userProfile;
  User? userFirebsase;

  @override
  void onInit() {
    super.onInit();
  }

  void login({userProfileParam: UserProfile}) async {
    isLoggedIn = true;
    await _getStorage.write('logged_in', isLoggedIn);
    await _getStorage.write('userProfile', jsonEncode(userProfileParam));
    debug.log(
        "Login userProfile from storage: ${_getStorage.read('userProfile')}");
    userProfile = userProfileParam;

    await Get.find<AnalyticsService>()
        .logAnalyticsEvent(logKey: AnalyticsConts.LOGIN_LOG);
  }

  void signUp({userProfileParam: UserProfile}) async {
    isLoggedIn = true;
    await _getStorage.write('logged_in', isLoggedIn);
    await _getStorage.write('userProfile', jsonEncode(userProfileParam));
    userProfile = userProfileParam;
    await Get.find<AnalyticsService>()
        .logAnalyticsEvent(logKey: AnalyticsConts.SIGN_UP_COMPLETED_LOG);
  }

  void logout() async {
    clean();
    await Get.find<AnalyticsService>()
        .logAnalyticsEvent(logKey: AnalyticsConts.LOGOUT_LOG);
    Get.offAll(() => HomeScreen());
  }

  void clean() async {
    await _getStorage.erase();
    userProfile = null;
    isLoggedIn = false;
    firstRun = _getStorage.read('first_run') ?? true;
  }

  void onBoarding() async {
    await _getStorage.write('first_run', false);
    firstRun = false;
  }

  Future<void> initSharedPrefs() async {
    _getStorage = GetStorage();
    firstRun = _getStorage.read('first_run') ?? true;
    isLoggedIn = _getStorage.read('logged_in') ?? false;
    localeLangCode = _getStorage.read('locale') ?? 'en';
    userProfile = _getStorage.read('userProfile') != null
        ? UserProfile.fromJson(jsonDecode(_getStorage.read('userProfile')))
        : null;
    // locale = constructLocale(langCode: localeLangCode);
  }

  Locale constructLocale({required String langCode}) {
    switch (langCode) {
      case 'en':
        return Locale('en', 'US');
      case 'ru':
        return Locale('ru', 'RU');
      default:
        return Locale('en', 'US');
    }
  }

  Future<void> saveUserLocale({required String newLocale}) async {
    await _getStorage.write('locale', newLocale);
    localeLangCode = _getStorage.read('locale') ?? 'en';
    locale = constructLocale(langCode: localeLangCode);
  }

  Future<void> hasLoggedIn() async {
    await _getStorage.write('logged_in', true);
  }

  Future<void> hasLoggedOut() async {
    await _getStorage.write('logged_in', false);
  }
}
