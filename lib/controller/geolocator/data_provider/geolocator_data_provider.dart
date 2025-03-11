import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GeolocatorDataProvider {
  Future<Position> getCurrentPosition() async {
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    try {
      bool servicesEnabled;
      LocationPermission permission;

      servicesEnabled = await Geolocator.isLocationServiceEnabled();
      if (!servicesEnabled) {
        return Future.error('A helymeghatározás ki van kapcsolva');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission == await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('A helymeghatározási engedély megtagadva');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error(
          'A helymeghatározási engedély véglegesen le van tiltva',
        );
      }

      return await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );
    } catch (e) {
      throw 'Hiba a helymeghatározásban';
    }
  }

  Future<String> getPlaceName(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );
      if (placemarks.isNotEmpty) {
        return placemarks.first.locality ?? "Ismeretlen hely";
      }
      throw "Nincs elérhető helyadat";
    } catch (e) {
      throw e.toString();
    }
  }
}
