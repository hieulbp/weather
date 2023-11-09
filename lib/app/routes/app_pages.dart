import 'package:get/get.dart';
import '../bindings/details_binding.dart';
import '../bindings/home_binding.dart';
import '../bindings/search_binding.dart';
import '../bindings/setting_binding.dart';
import '../ui/screen/detail/details_screen.dart';
import '../ui/screen/home/home_screen.dart';
import '../ui/screen/search/search_screen.dart';
import '../ui/screen/setting/setting_screen.dart';
part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: Routes.INITIAL,
        page: () => HomeScreen(),
        binding: HomeBinding()),
    GetPage(
        name: Routes.DETAILS,
        page: () => DetailsScreen(),
        binding: DetailsBinding()),
    GetPage(
        name: Routes.SEARCH,
        page: () => SearchScreen(),
        binding: SearchBinding()),
    GetPage(
        name: Routes.SETTING,
        page: () => SettingScreen(),
        binding: SettingBinding()),
  ];
}
