class IpResponse {
  IpResponse({
      this.countryCode, 
      this.countryName, 
      this.city, 
      this.postal, 
      this.latitude, 
      this.longitude, 
      this.iPv4, 
      this.state,});

  IpResponse.fromJson(dynamic json) {
    countryCode = json['country_code'];
    countryName = json['country_name'];
    city = json['city'];
    postal = json['postal'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    iPv4 = json['IPv4'];
    state = json['state'];
  }
  String? countryCode;
  String? countryName;
  String? city;
  dynamic postal;
  num? latitude;
  num? longitude;
  String? iPv4;
  String? state;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['country_code'] = countryCode;
    map['country_name'] = countryName;
    map['city'] = city;
    map['postal'] = postal;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['IPv4'] = iPv4;
    map['state'] = state;
    return map;
  }

}