import 'package:get/get.dart';
import '../../data/repository/detail/detail_repo.dart';
import '../../data/repository/detail/detail_repo_impl.dart';

class DetailsController extends GetxController {

  late DetailRepo _repo;

  DetailsController(){
    _repo = Get.find<DetailRepoImpl>();
  }



}