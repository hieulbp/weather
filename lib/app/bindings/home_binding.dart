import 'package:get/get.dart';

import '../controller/home/home_controller.dart';
import '../data/repository/detail/detail_repo_impl.dart';

class HomeBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<DetailRepoImpl>(() => DetailRepoImpl(), fenix: true);

  }

}