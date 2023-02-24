import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../data/data/model/lat_long.dart';
class SplashViewModel extends ChangeNotifier {
  SplashViewModel() {
    fetchCurrentLocation();
    listenCurrentLocation();
  }

  LatLong? latLong;

  Location location = Location();

  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;

  Future<void> fetchCurrentLocation() async {
    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }


    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    LocationData locationData = await location.getLocation();
    latLong = LatLong(
      latitude: locationData.latitude!,
      longitude: locationData.longitude!,
    );
    await Future.delayed(const Duration(seconds: 3));
    notifyListeners();
  }

  listenCurrentLocation() {
    location.onLocationChanged.listen((event) {
    });
  }
}