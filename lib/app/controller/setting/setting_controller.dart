import 'package:get/get.dart';

import '../../data/repository/detail/detail_repo.dart';
import '../../data/repository/detail/detail_repo_impl.dart';

class SettingController extends GetxController {

  late DetailRepo _repo;

  SettingController(){
    _repo = Get.find<DetailRepoImpl>();
  }



}