part of 'geolocator_bloc.dart';

@immutable
sealed class GeolocatorEvent {}

final class GeolocatorFetched extends GeolocatorEvent {}
