import 'dart:async';

import 'package:filo_assignment/utils/app_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart' as geo_locator;
import 'package:geolocator/geolocator.dart';

class LocationUtils {
  static final LocationUtils _locationUtils = LocationUtils._internal();

  factory LocationUtils() => _locationUtils;

  LocationUtils._internal();

  final geo_locator.GeolocatorPlatform geoLocator =
      geo_locator.GeolocatorPlatform.instance;
  final _locationStreamController = StreamController<Position>.broadcast();
  void Function(Position data) get addLocationPositionStream => _locationStreamController.sink.add;
  Stream<Position> get listenLocationPositionStream => _locationStreamController.stream;

  checkLocationService({required Function onGranted}) async {
    if (kDebugMode) {
      print('####====> checkLocationService() called');
    }
    geo_locator.LocationPermission permission;
    var isServiceEnabled = await geo_locator.Geolocator.isLocationServiceEnabled();

    if (isServiceEnabled) {
      onGranted();
    } /*else {
      isEnabled = await GeoLocator.Geolocator.requestPermission();
      if (isEnabled) onGranted();
    }*/

    permission = await geo_locator.Geolocator.checkPermission();
    if (permission == geo_locator.LocationPermission.denied) {
      permission = await geo_locator.Geolocator.requestPermission();
      if (permission == geo_locator.LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == geo_locator.LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  getCurrentLocation() {
      geoLocator.getLastKnownPosition(forceLocationManager: true).then((position) {
        if(position != null){
          AppUtils.lastLocation = position;
          if (kDebugMode) {
            print("LastKnown Location => ${position.latitude} :: ${position.longitude}");
          }
        }else{
          if (kDebugMode) {
            print("LastKnown Location => null :: $position");
          }
        }
      });

    geoLocator
        .getCurrentPosition(locationSettings: const geo_locator
        .LocationSettings(accuracy: geo_locator.LocationAccuracy.best))
        .then((geo_locator.Position position) async{
          if (kDebugMode) {
            print("Getting Current Location => ${position.latitude} "
              ":: ${position.longitude}");
          }

          addLocationPositionStream(position);

          List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
          print("Address => ${placemarks.first.locality} :: ${placemarks.first.subLocality}");

          AppUtils.lastLocation = position;

    }).catchError((e) {
      if (kDebugMode) {
        print("Exception => $e");
      }
    });
  }
}
