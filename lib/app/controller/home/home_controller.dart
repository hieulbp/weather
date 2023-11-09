import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/app/data/model/forescast_response.dart';
import 'package:weather/app/ui/theme/app_colors.dart';
import 'package:weather/manager/setting_manager.dart';

import '../../data/model/current_response.dart';
import '../../data/repository/detail/detail_repo.dart';
import '../../data/repository/detail/detail_repo_impl.dart';

class HomeController extends GetxController {

  late DetailRepo _repo;

  var currentResponse = CurrentResponse().obs;
  var currentForecast = ForescastResponse().obs;

  var isNight = false.obs;

  var temp = '-/-'.obs;
  var condition = '-/-'.obs;
  var maxTemp = '-/-'.obs;
  var minTemp = '-/-'.obs;
  var cityName = '-/-'.obs;
  var wind = '-/-'.obs;
  var tempFeel = '-/-'.obs;
  var uv = '-/-'.obs;
  var vis = '-/-'.obs;
  var airq = '-/-'.obs;

  var qr = '';

  var assetImage = 'assets/images/day/113.svg';

  var isEnglish = false.obs;
  var isVietnamese = true.obs;

  var isTempC = true.obs;
  var isTempF = false.obs;

  HomeController(){
    _repo = Get.find<DetailRepoImpl>();



  }

  handleData(){
    if(SettingManager.shared.typeTemp == 0){
      temp.value = currentForecast.value.current?.tempC?.toStringAsFixed(0) ?? '';
      maxTemp.value = currentForecast.value.forecast?.forecastday?.first.day?.maxtempC?.toStringAsFixed(0) ?? '';
      minTemp.value = currentForecast.value.forecast?.forecastday?.first.day?.mintempC?.toStringAsFixed(0) ?? '';
      tempFeel.value = currentForecast.value.current?.feelslikeC?.toStringAsFixed(0) ?? '';

    } else {
      temp.value = currentForecast.value.current?.tempF?.toStringAsFixed(0) ?? '';
      maxTemp.value = currentForecast.value.forecast?.forecastday?.first.day?.maxtempF?.toStringAsFixed(0) ?? '';
      minTemp.value = currentForecast.value.forecast?.forecastday?.first.day?.mintempF?.toStringAsFixed(0) ?? '';
      tempFeel.value = currentForecast.value.current?.feelslikeF?.toStringAsFixed(0) ?? '';


    }

    if(SettingManager.shared.typeWind == 0){
      wind.value = '${currentForecast.value.current?.windMph} M/h';

    } else {
      wind.value ='${currentForecast.value.current?.windKph} Km/h';

    }


    var numberAir = currentForecast.value.forecast?.forecastday?.first.day?.airQuality?.gbdefraindex?.toInt() ?? 0;
    if(numberAir < 4){
        airq.value = 'Low'.tr;
    } else if (numberAir > 3 && numberAir < 7) {
        airq.value = 'Moderate'.tr;
    } else if (numberAir > 6 && numberAir < 10) {
      airq.value = 'High'.tr;
    } else {
      airq.value = 'Very High'.tr;
    }


    uv.value = currentForecast.value.forecast?.forecastday?.first.day?.uv?.toStringAsFixed(0).toString() ?? '';
    condition.value = currentForecast.value.current?.condition?.text.toString() ?? '';
    cityName.value = currentForecast.value.location?.name.toString() ?? '';

    String result = extractValueFromUrl(currentForecast.value.current?.condition?.icon ?? '');
    print(result);

    assetImage = 'assets/images${result}.svg';


  }

  String extractValueFromUrl(String url) {
    int startIndex = url.indexOf("64x64");
    int endIndex = url.indexOf(".", startIndex);
    if (endIndex == -1) {
      endIndex = url.length;
    }
    String value = url.substring(startIndex + 5, endIndex);

    return value;
  }


  getMyIp() async {
    var result = await _repo.getMyIp();
    if(result != null) {
      qr = result.iPv4 ?? '';

      print(result.toJson().toString());

    }
  }

  getDataCurrent() async {
    Map<String, String> queryParam = {
      'q' : '173.239.196.205'
    };

    var result = await _repo.getCurrent(queryParam);
    if(result != null) {
      currentResponse.value = result;

      print(currentResponse.toJson().toString());

    } else {

    }

  }

  getDataForecast({String? q}) async {

    if(qr.isEmpty) await getMyIp();

    Map<String, String> queryParam = {
      'q' : q ?? qr,
      'days' : '10',
      'aqi' : 'yes',
      'lang' : SettingManager.shared.language.value


    };

    var result = await _repo.getForecast(queryParam);
    if(result != null) {
      currentForecast.value = result;

      handleData();

    }

    DateTime _timeoutAt;

    _timeoutAt = DateTime.now().add(const Duration(minutes: 30));
    Timer _timerCheckIsTimeout = Timer.periodic(const Duration(seconds: 15), (timer) async {
      final isTimeout = DateTime.now().isAfter(_timeoutAt);
      if (isTimeout) {

        timer.cancel();
        getDataForecast();
      }
    });



  }

  String showMessageWelcome() {
    DateTime now = DateTime.now();
    String greeting = "";
    int hours = now.hour;

    if(hours>=6 && hours<=12){
      greeting = "Good Morning!".tr;
    } else if(hours>=12 && hours<=16){
      greeting = "Good Afternoon!".tr;
    } else if(hours>=16 && hours<=21){
      greeting = "Good Evening!".tr;
    } else if(hours>=21 && hours<=24){
      greeting = "Good Night!".tr;
    } else {
      greeting = "Good Night!".tr;
    }

    return '$greeting Homebase';

  }

  LinearGradient checkNight(){
    DateTime now = DateTime.now();
    int hours = now.hour;
    if(hours >= 5 && hours <= 17){
      return colorBackgroundDay;
    } else {
      return colorBackgroundNight;
    }
  }

  getDataLocal(){
    if(SettingManager.shared.typeTemp == 0){
      isTempC.value = true;
      isTempF.value = false;
    } else {
      isTempC.value = false;
      isTempF.value = true;
    }

    if(SettingManager.shared.language.value == 'vi'){
      isVietnamese.value = true;
      isEnglish.value = false;
    } else {
      isVietnamese.value = false;
      isEnglish.value = true;
    }
  }

  saveSetting() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();


    if(isTempC.value == true){

      await prefs.setInt('temperature', 0);
      SettingManager.shared.typeTemp = 0;


    } else {
      await prefs.setInt('temperature', 1);
      SettingManager.shared.typeTemp = 1;

    }

    if(isVietnamese.value == true){
      await prefs.setString('language', 'vi');
      SettingManager.shared.language.value = 'vi';

    } else {
      await prefs.setString('language', 'en');
      SettingManager.shared.language.value = 'en';

    }
    Get.updateLocale(Locale(SettingManager.shared.language.value));
    handleData();

  }

  clearData(){
    temp.value = '-/-';
    condition.value = '-/-';
    maxTemp.value = '-/-';
    minTemp.value = '-/-';
    cityName.value = '-/-';
    wind.value = '-/-';
    tempFeel.value = '-/-';
    uv.value = '-/-';
    vis.value = '-/-';
    airq.value = '-/-';
    currentForecast.value = ForescastResponse();
  }

}