import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_app/controller/weather/repository/weather_repository.dart';
import 'package:weather_app/model/weather_model.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<WeatherFetchedByLocation>(_getWeatherDataByLocation);
  }

  void _getWeatherDataByLocation(
    WeatherFetchedByLocation event,
    Emitter<WeatherState> emit,
  ) async {
    try {
      emit(WeatherLoading());
      final weather = await weatherRepository.getCurrentWeather(event.cityName);
      emit(WeatherSuccess(weatherModelList: weather));
    } catch (e) {
      emit(WeatherFailure(e.toString()));
    }
  }
}
