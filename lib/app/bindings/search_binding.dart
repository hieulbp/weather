import 'package:get/get.dart';
import 'package:weather/app/data/repository/search/search_repo_impl.dart';
import '../controller/search/search_controller.dart';

class SearchBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SearchController>(() => SearchController(), fenix: true);
    Get.lazyPut<SearchRepoImpl>(() => SearchRepoImpl(), fenix: true);

  }

}