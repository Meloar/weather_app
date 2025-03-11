import 'package:geolocator/geolocator.dart';
import 'package:weather_app/controller/geolocator/data_provider/geolocator_data_provider.dart';

class GeolocatorRepository {
  GeolocatorRepository(this.geolocatorDataProvider);

  final GeolocatorDataProvider geolocatorDataProvider;

  Future<String> getCurrentLocation() async {
    try {
      Position position = await geolocatorDataProvider.getCurrentPosition();

      return await geolocatorDataProvider.getPlaceName(
        position.latitude,
        position.longitude,
      );
    } catch (e) {
      throw e.toString();
    }
  }
}
