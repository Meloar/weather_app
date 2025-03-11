import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_app/controller/geolocator/repository/geolocator_repository.dart';

part 'geolocator_event.dart';
part 'geolocator_state.dart';

class GeolocatorBloc extends Bloc<GeolocatorEvent, GeolocatorState> {
  final GeolocatorRepository geolocatorRepository;
  GeolocatorBloc(this.geolocatorRepository) : super(GeolocatorInitial()) {
    on<GeolocatorFetched>(_getCurrentLocation);
  }

  void _getCurrentLocation(
    GeolocatorFetched event,
    Emitter<GeolocatorState> emit,
  ) async {
    emit(GeolocatorLoading());
    try {
      final currentLocation = await geolocatorRepository.getCurrentLocation();
      emit(GeolocatorSuccess(currentLocation: currentLocation));
    } catch (e) {
      emit(GeolocatorFailure(e.toString()));
    }
  }
}
