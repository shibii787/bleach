class WeatherModel {
  final Location location;
  final Current current;

  WeatherModel({
    required this.location,
    required this.current,
  });

  Map<String, dynamic> toJson() {
    return {
      'location': location.toJson(),
      'current': current.toJson(),
    };
  }

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      location: Location.fromJson(json['location']),
      current: Current.fromJson(json['current']),
    );
  }
}

class Location {
  final String name;
  final String? region;
  final String? country;

  Location({
    required this.name,
    this.region,
    this.country,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'region': region,
      'country': country,
    };
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'] ?? 'Unknown',
      region: json['region'] ?? 'Unknown',
      country: json['country'] ?? 'Unknown',
    );
  }
}

class Current {
  final double tempC;
  final double feelsLikeC;
  final int humidity;
  final double windKph;
  final String windDir;
  final double uv;
  final double visibilityKm;
  final double pressureMb;
  final Condition condition;

  Current({
    required this.tempC,
    required this.feelsLikeC,
    required this.humidity,
    required this.windKph,
    required this.windDir,
    required this.uv,
    required this.visibilityKm,
    required this.pressureMb,
    required this.condition,
  });

  Map<String, dynamic> toJson() {
    return {
      'temp_c': tempC,
      'feelslike_c': feelsLikeC,
      'humidity': humidity,
      'wind_kph': windKph,
      'wind_dir': windDir,
      'uv': uv,
      'vis_km': visibilityKm,
      'pressure_mb': pressureMb,
      'condition': condition.toJson(),
    };
  }

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      tempC: json['temp_c'] ?? 0.0,
      feelsLikeC: json['feelslike_c'] ?? 0.0,
      humidity: json['humidity'] ?? 0,
      windKph: json['wind_kph'] ?? 0.0,
      windDir: json['wind_dir'] ?? '',
      uv: json['uv'] ?? 0.0,
      visibilityKm: json['vis_km'] ?? 0.0,
      pressureMb: json['pressure_mb'] ?? 0.0,
      condition: Condition.fromJson(json['condition']),
    );
  }
}

class Condition {
  final String text;
  final String icon;

  Condition({
    required this.text,
    required this.icon,
  });

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'icon': icon,
    };
  }

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      text: json['text'],
      icon: json['icon'],
    );
  }
}
