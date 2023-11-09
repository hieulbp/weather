import 'location.dart';
import 'current.dart';
class CurrentResponse {
  CurrentResponse({
      Location? location, 
      Current? current,}){
    _location = location;
    _current = current;
}

  CurrentResponse.fromJson(dynamic json) {
    _location = json['location'] != null ? Location.fromJson(json['location']) : null;
    _current = json['current'] != null ? Current.fromJson(json['current']) : null;
  }
  Location? _location;
  Current? _current;

  Location? get location => _location;
  Current? get current => _current;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_location != null) {
      map['location'] = _location?.toJson();
    }
    if (_current != null) {
      map['current'] = _current?.toJson();
    }
    return map;
  }

}


