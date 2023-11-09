import 'dart:convert';

import 'package:get/get.dart';
import 'package:weather/app/data/model/ip_response.dart';
import '../../../values/constant.dart';
import '../../model/current_response.dart';
import '../../model/forescast_response.dart';
import '../../service/http_service.dart';
import '../../service/http_service_impl.dart';
import 'detail_repo.dart';

class DetailRepoImpl implements DetailRepo {

  late HttpService httpService;

  DetailRepoImpl(){
    httpService = Get.put(HttpServiceImpl());
    httpService.init();

  }

  @override
  Future<CurrentResponse?> getCurrent(Map<String, String> query) async {

    try {
      final response = await httpService.getRequest(Constant.API_GET_CURRENT, query: query);

      final parsedResponse = CurrentResponse.fromJson(response.data);

      return parsedResponse;
    } on Exception catch (e) {
      print(e);
      return null;
    }

  }

  @override
  Future<ForescastResponse?> getForecast(Map<String, String> query) async {

    try {
      final response = await httpService.getRequest(Constant.API_GET_FORECAST, query: query);

      final parsedResponse = ForescastResponse.fromJson(response.data);

      return parsedResponse;
    } on Exception catch (e) {
      print(e);
      return null;
    }

  }

  @override
  Future<IpResponse?> getMyIp() async {

    try {
      final response = await httpService.getRequest(Constant.API_GET_MYIP);

      final body = json.decode(response.data);
      final parsedResponse = IpResponse.fromJson(body);

      return parsedResponse;
    } on Exception catch (e) {
      print(e);
      return null;
    }

  }
}