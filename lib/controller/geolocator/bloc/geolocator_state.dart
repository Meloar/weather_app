part of 'geolocator_bloc.dart';

@immutable
sealed class GeolocatorState {}

final class GeolocatorInitial extends GeolocatorState {}

final class GeolocatorSuccess extends GeolocatorState {
  final String currentLocation;

  GeolocatorSuccess({required this.currentLocation});
}

final class GeolocatorFailure extends GeolocatorState {
  final String error;
  GeolocatorFailure(this.error);
}

final class GeolocatorLoading extends GeolocatorState {}
