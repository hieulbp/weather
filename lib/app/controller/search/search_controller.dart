import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/app/data/model/search_response.dart';
import 'package:weather/app/data/repository/search/search_repo.dart';
import 'package:weather/app/data/repository/search/search_repo_impl.dart';

import '../../data/repository/detail/detail_repo.dart';
import '../../data/repository/detail/detail_repo_impl.dart';

class SearchController extends GetxController {

  late SearchRepo _repo;
  var editController = TextEditingController();
  var hasSearchFocus = false;
  Timer? _typingTimer;

  var listLocation = <SearchResponse>[].obs;

  SearchController(){
    _repo = Get.find<SearchRepoImpl>();
  }


  onSearchChanged(String query) {
    if (_typingTimer?.isActive ?? false) _typingTimer!.cancel();
    _typingTimer = Timer(const Duration(milliseconds: 500), () async {

      await doSearch(query);

    });
  }

  doSearch(String query) async {
    Map<String, String> queryParam = {
      'q' : query
    };

    var result = await _repo.getSearch(queryParam);
    if(result != null) {

      if(result.isNotEmpty){
        listLocation.clear();
        listLocation.addAll(result);
      } else {
        listLocation.clear();
      }


    } else {
      listLocation.clear();
    }
  }

}