import 'dart:convert';

class WeatherModel {
  final double temperature;
  final String sky;
  final double pressure;
  final double windSpeed;
  final double humidity;
  final String icon;
  WeatherModel({
    required this.temperature,
    required this.sky,
    required this.pressure,
    required this.windSpeed,
    required this.humidity,
    required this.icon,
  });

  WeatherModel copyWith({
    double? temperature,
    String? sky,
    double? pressure,
    double? windSpeed,
    double? humidity,
    String? icon,
  }) {
    return WeatherModel(
      temperature: temperature ?? this.temperature,
      sky: sky ?? this.sky,
      pressure: pressure ?? this.pressure,
      windSpeed: windSpeed ?? this.windSpeed,
      humidity: humidity ?? this.humidity,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'temperature': temperature,
      'sky': sky,
      'pressure': pressure,
      'windSpeed': windSpeed,
      'humidity': humidity,
      'icon': icon,
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map, int index) {
    final weatherData = map['list'][index];

    return WeatherModel(
      temperature: weatherData['main']['temp'],
      sky: weatherData['weather'][0]['main'],
      pressure: (weatherData['main']['pressure'] as num).toDouble(),
      windSpeed: (weatherData['wind']['speed'] as num).toDouble(),
      humidity: (weatherData['main']['humidity'] as num).toDouble(),
      icon: weatherData['weather'][0]['icon'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source, int index) =>
      WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>, index);

  @override
  String toString() {
    return 'WeatherModel(temperature: $temperature, sky: $sky, pressure: $pressure, windSpeed: $windSpeed, humidity: $humidity, icon: $icon)';
  }

  @override
  bool operator ==(covariant WeatherModel other) {
    if (identical(this, other)) return true;

    return other.temperature == temperature &&
        other.sky == sky &&
        other.pressure == pressure &&
        other.windSpeed == windSpeed &&
        other.humidity == humidity &&
        other.icon == icon;
  }

  @override
  int get hashCode {
    return temperature.hashCode ^
        sky.hashCode ^
        pressure.hashCode ^
        windSpeed.hashCode ^
        humidity.hashCode ^
        icon.hashCode;
  }
}
