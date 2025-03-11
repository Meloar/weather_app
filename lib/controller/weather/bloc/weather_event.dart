part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

final class WeatherFetchedByLocation extends WeatherEvent {
  final String cityName;

  WeatherFetchedByLocation({required this.cityName});
}

final class WeatherFetchedByCityName extends WeatherEvent {
  final String cityName;

  WeatherFetchedByCityName({required this.cityName});
}
