
import 'package:get/get.dart';

class SettingManager {

  static final shared = SettingManager();

  var isConnected = true.obs;

  var language = 'vi'.obs;
  var typeTemp = 0; //0 is C, 1 is F
  var typeWind = 1; // 0 is mph, 1 is kph


}