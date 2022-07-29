import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';

class AnalyticsService extends GetxService {
  late FirebaseAnalytics analytics;
  late FirebaseAnalyticsObserver observer;
  @override
  void onInit() {
    analytics = FirebaseAnalytics.instance;
    observer = FirebaseAnalyticsObserver(analytics: analytics);
    super.onInit();
  }

  Future<void> logAnalyticsEvent(
      {required String logKey, Map<String, String>? args}) async {
    if (args != null) {
      await analytics.logEvent(
        name: logKey,
        parameters: args,
      );
    } else {
      await analytics.logEvent(
        name: logKey,
      );
    }
  }
}

class AnalyticsConts {
  static String LOGIN_LOG = 'LOGIN_LOG';
  static String LOGOUT_LOG = 'LOGOUT_LOG';
  static String OPEN_NEWS = 'OPEN_NEWS';
  static String OPEN_MEDIA = 'OPEN_MEDIA';
  static String OPEN_PARTICIPATION_LOCATIONS_LOG =
      'OPEN_PARTICIPATION_LOCATIONS_LOG';
  static String OPEN_LOC_LOCATION_LOG = 'OPEN_LOC_LOCATION_LOG';
  static String CALL_LOC_LOG = 'CALL_LOC_LOG';
  static String OPEN_REPORT_DOC_LOG = 'OPEN_REPORT_DOC_LOG';
  static String WHATSAPP_LOC_LOG = 'WHATSAPP_LOC_LOG';
  static String OPEN_REPORT_PAGE = 'OPEN_REPORT_PAGE';
  static String DOWNLOAD_REPORTT = 'DOWNLOAD_REPORTT';
  static String LOGIN_ERROR_SOP3 = 'LOGIN_ERROR_SOP3';
}
