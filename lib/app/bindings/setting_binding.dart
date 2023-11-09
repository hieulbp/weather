import 'package:get/get.dart';
import '../controller/search/search_controller.dart';
import '../controller/setting/setting_controller.dart';

class SettingBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(() => SettingController(), fenix: true);

  }

}