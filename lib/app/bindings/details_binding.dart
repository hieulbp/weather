import 'package:get/get.dart';

import '../controller/detail/details_controller.dart';
import '../data/repository/detail/detail_repo_impl.dart';

class DetailsBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DetailsController>(() => DetailsController(), fenix: true);
    Get.lazyPut<DetailRepoImpl>(() => DetailRepoImpl(), fenix: true);

  }

}