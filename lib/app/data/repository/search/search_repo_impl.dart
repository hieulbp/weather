import 'dart:convert';

import 'package:get/get.dart';
import 'package:weather/app/data/repository/search/search_repo.dart';
import '../../../values/constant.dart';
import '../../model/search_response.dart';
import '../../service/http_service.dart';
import '../../service/http_service_impl.dart';

class SearchRepoImpl implements SearchRepo {

  late HttpService httpService;

  SearchRepoImpl() {
    httpService = Get.put(HttpServiceImpl());
    httpService.init();
  }

  @override
  Future<List<SearchResponse>?> getSearch(Map<String, String> query) async {
    try {
      final response = await httpService.getRequest(
          Constant.API_GET_SEARCH, query: query);

      List<SearchResponse> data = List<SearchResponse>.from(response.data.map((model)=> SearchResponse.fromJson(model)));

      return data;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }
}