import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/routes/app_pages.dart';
import 'app/translations/app_translations.dart';
import 'app/ui/theme/app_theme.dart';
import 'manager/setting_manager.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  InternetConnectionChecker().onStatusChange.listen((status) {
    switch (status) {
      case InternetConnectionStatus.connected:
        print('Data connection is available.');
        SettingManager.shared.isConnected.value = true;
        break;
      case InternetConnectionStatus.disconnected:
        print('You are disconnected from the internet.');
        SettingManager.shared.isConnected.value = false;
        break;
    }
  });

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var language =  prefs.getString('language');
  if(language != null && language.isNotEmpty){
    SettingManager.shared.language.value = language;
  } else {
    await prefs.setString('language', SettingManager.shared.language.value);
  }

  var temperature =  prefs.getInt('temperature');
  if(temperature != null ){
    SettingManager.shared.typeTemp = temperature;
  } else {
    await prefs.setInt('temperature', SettingManager.shared.typeTemp);
  }

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.INITIAL,
    theme: appThemeData,
    defaultTransition: Transition.fade,
    getPages: AppPages.pages,
    locale: Locale(SettingManager.shared.language.value),
    translationsKeys: AppTranslation.translations,
  ));
}




