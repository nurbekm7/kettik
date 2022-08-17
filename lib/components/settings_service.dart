import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kettik/components/analytics_controller.dart';
import 'package:kettik/screens/home/home_screen.dart';

class SettingsService extends GetxService {
  late GetStorage _getStorage = GetStorage();
  late bool firstRun = true;
  late bool loggedIn = false;
  late String userToken = '';
  late String userId = '';
  late String localeLangCode = '';
  late Locale locale = Locale('en', 'US');
  //new
  late String userName = '';
  late String phoneNumber = '';

  // late String reportFilePath = '';
  late String env = '';
  @override
  void onInit() {
    super.onInit();
  }

  void logout() async {
    env = _getStorage.read('env');
    await _getStorage.erase();
    await _getStorage.write('env', env);
    loggedIn = false;
    firstRun = _getStorage.read('first_run') ?? true;
    userId = _getStorage.read('userId') ?? '';
    userToken = _getStorage.read('userToken') ?? '';
    userName = _getStorage.read('userName') ?? '';
    phoneNumber = _getStorage.read('phoneNumber') ?? '';
    await Get.find<AnalyticsService>()
        .logAnalyticsEvent(logKey: AnalyticsConts.LOGOUT_LOG);
    Get.offAll(() => HomeScreen());
  }

  void clean() async {
    env = _getStorage.read('env');
    await _getStorage.erase();
    await _getStorage.write('env', env);
    loggedIn = false;
    firstRun = _getStorage.read('first_run') ?? true;
    userId = _getStorage.read('userId') ?? '';
    userToken = _getStorage.read('userToken') ?? '';
    userName = _getStorage.read('userName') ?? '';
    phoneNumber = _getStorage.read('phoneNumber') ?? '';
  }

  void alterDiologLoginError({required String errorCode}) async {
    clean();
    loggedIn = false;
    await _getStorage.write('login_error', errorCode);
    await Get.find<AnalyticsService>()
        .logAnalyticsEvent(logKey: AnalyticsConts.LOGIN_ERROR_SOP3);
    Get.offAll(() => HomeScreen());
  }

  void onBoarding() async {
    await _getStorage.write('first_run', false);
    firstRun = false;
  }

  void setEnv({required String env}) async {
    await _getStorage.write('env', env);
    env = env;
  }

  Future<void> initSharedPrefs() async {
    print("logged_in: " + _getStorage.read('logged_in').toString());
    _getStorage = GetStorage();
    firstRun = _getStorage.read('first_run') ?? true;
    loggedIn = _getStorage.read('logged_in') ?? false;
    userId = _getStorage.read('userId') ?? '';
    userToken = _getStorage.read('userToken') ?? '';
    userName = _getStorage.read('userName') ?? '';
    phoneNumber = _getStorage.read('phoneNumber') ?? '';
    localeLangCode = _getStorage.read('locale') ?? 'en';
    env = _getStorage.read('env') ?? '';
    locale = constructLocale(langCode: localeLangCode);
  }

  Locale constructLocale({required String langCode}) {
    switch (langCode) {
      case 'en':
        return Locale('en', 'US');
      default:
        return Locale('en', 'US');
    }
  }

  Future<void> saveUserToken({required String newToken}) async {
    await _getStorage.write('userToken', newToken);
    userToken = _getStorage.read('userToken') ?? '';
  }

  Future<void> saveUserLocale({required String newLocale}) async {
    await _getStorage.write('locale', newLocale);
    localeLangCode = _getStorage.read('locale') ?? 'en';
    locale = constructLocale(langCode: localeLangCode);
  }

  Future<void> saveUserId({required String newId}) async {
    await _getStorage.write('userId', newId);
    userId = _getStorage.read('userId') ?? '';
  }

  Future<void> hasLoggedIn() async {
    await _getStorage.write('logged_in', true);
  }

  Future<void> hasLoggedOut() async {
    await _getStorage.write('logged_in', false);
  }

  Future<void> loggedInType({required String loggedInType}) async {
    await _getStorage.write('logged_in_type', loggedInType);
  }

  Future<void> savePhoneNumber({required String update}) async {
    await _getStorage.write('phoneNumber', update);
    phoneNumber = _getStorage.read('phoneNumber') ?? '';
  }
}
