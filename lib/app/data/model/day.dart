import 'condition.dart';
import 'air_quality.dart';

class Day {
  Day({
      this.maxtempC, 
      this.maxtempF, 
      this.mintempC, 
      this.mintempF, 
      this.avgtempC, 
      this.avgtempF, 
      this.maxwindMph, 
      this.maxwindKph, 
      this.totalprecipMm, 
      this.totalprecipIn, 
      this.totalsnowCm, 
      this.avgvisKm, 
      this.avgvisMiles, 
      this.avghumidity, 
      this.dailyWillItRain, 
      this.dailyChanceOfRain, 
      this.dailyWillItSnow, 
      this.dailyChanceOfSnow, 
      this.condition, 
      this.uv, 
      this.airQuality,});

  Day.fromJson(dynamic json) {
    maxtempC = json['maxtemp_c'];
    maxtempF = json['maxtemp_f'];
    mintempC = json['mintemp_c'];
    mintempF = json['mintemp_f'];
    avgtempC = json['avgtemp_c'];
    avgtempF = json['avgtemp_f'];
    maxwindMph = json['maxwind_mph'];
    maxwindKph = json['maxwind_kph'];
    totalprecipMm = json['totalprecip_mm'];
    totalprecipIn = json['totalprecip_in'];
    totalsnowCm = json['totalsnow_cm'];
    avgvisKm = json['avgvis_km'];
    avgvisMiles = json['avgvis_miles'];
    avghumidity = json['avghumidity'];
    dailyWillItRain = json['daily_will_it_rain'];
    dailyChanceOfRain = json['daily_chance_of_rain'];
    dailyWillItSnow = json['daily_will_it_snow'];
    dailyChanceOfSnow = json['daily_chance_of_snow'];
    condition = json['condition'] != null ? Condition.fromJson(json['condition']) : null;
    uv = json['uv'];
    airQuality = json['air_quality'] != null ? AirQuality.fromJson(json['air_quality']) : null;
  }
  num? maxtempC;
  num? maxtempF;
  num? mintempC;
  num? mintempF;
  num? avgtempC;
  num? avgtempF;
  num? maxwindMph;
  num? maxwindKph;
  num? totalprecipMm;
  num? totalprecipIn;
  num? totalsnowCm;
  num? avgvisKm;
  num? avgvisMiles;
  num? avghumidity;
  num? dailyWillItRain;
  num? dailyChanceOfRain;
  num? dailyWillItSnow;
  num? dailyChanceOfSnow;
  Condition? condition;
  num? uv;
  AirQuality? airQuality;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['maxtemp_c'] = maxtempC;
    map['maxtemp_f'] = maxtempF;
    map['mintemp_c'] = mintempC;
    map['mintemp_f'] = mintempF;
    map['avgtemp_c'] = avgtempC;
    map['avgtemp_f'] = avgtempF;
    map['maxwind_mph'] = maxwindMph;
    map['maxwind_kph'] = maxwindKph;
    map['totalprecip_mm'] = totalprecipMm;
    map['totalprecip_in'] = totalprecipIn;
    map['totalsnow_cm'] = totalsnowCm;
    map['avgvis_km'] = avgvisKm;
    map['avgvis_miles'] = avgvisMiles;
    map['avghumidity'] = avghumidity;
    map['daily_will_it_rain'] = dailyWillItRain;
    map['daily_chance_of_rain'] = dailyChanceOfRain;
    map['daily_will_it_snow'] = dailyWillItSnow;
    map['daily_chance_of_snow'] = dailyChanceOfSnow;
    if (condition != null) {
      map['condition'] = condition?.toJson();
    }
    map['uv'] = uv;
    if (airQuality != null) {
      map['air_quality'] = airQuality?.toJson();
    }
    return map;
  }

}