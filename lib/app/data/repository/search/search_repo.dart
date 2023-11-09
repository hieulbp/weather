

import '../../model/search_response.dart';

abstract class SearchRepo {
  Future<List<SearchResponse>?> getSearch(Map<String, String> query);


}