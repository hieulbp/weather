class SearchResponse {
  SearchResponse({
      this.id, 
      this.name, 
      this.region, 
      this.country, 
      this.lat, 
      this.lon, 
      this.url,});

  SearchResponse.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    region = json['region'];
    country = json['country'];
    lat = json['lat'];
    lon = json['lon'];
    url = json['url'];
  }
  num? id;
  String? name;
  String? region;
  String? country;
  num? lat;
  num? lon;
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['region'] = region;
    map['country'] = country;
    map['lat'] = lat;
    map['lon'] = lon;
    map['url'] = url;
    return map;
  }

}