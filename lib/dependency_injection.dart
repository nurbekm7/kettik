import 'package:get/instance_manager.dart';
import 'package:kettik/components/analytics_controller.dart';
import 'package:kettik/components/settings_service.dart';
import 'package:kettik/screens/sign_in/auth_controller.dart';

class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
    Get.put(AnalyticsService());
    Get.lazyPut<SettingsService>(() => SettingsService());
  }
}
