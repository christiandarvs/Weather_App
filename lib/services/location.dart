import 'package:geolocator/geolocator.dart';

class Location {
  late double latitude = 1;
  late double longitude = 1;

  Future<void> getLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        latitude = position.latitude;
        longitude = position.longitude;
      }
    } catch (e) {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        latitude = position.latitude;
        longitude = position.longitude;
      }
    }
  }
}
