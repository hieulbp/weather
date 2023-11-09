
import 'package:weather/app/data/model/ip_response.dart';

import '../../model/current_response.dart';
import '../../model/forescast_response.dart';

abstract class DetailRepo {
  Future<CurrentResponse?> getCurrent(Map<String, String> query);

  Future<ForescastResponse?> getForecast(Map<String, String> query);

  Future<IpResponse?> getMyIp();

}