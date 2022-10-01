import 'package:get/get.dart';

import '../../utils/location_utils.dart' as locationUtils;
import '../../utils/permission_utils.dart' as permissionUtils;
import 'package:permission_handler/permission_handler.dart' as pm_handler;

class WeatherController extends GetxController{

  @override
  void onInit() {
    super.onInit();

    _getPermission();
  }

  _getPermission() {
    permissionUtils.PermissionUtils().askForPermission(pm_handler
        .Permission.location, onGranted: () {
      locationUtils.LocationUtils().checkLocationService(onGranted: () {
        locationUtils.LocationUtils().getCurrentLocation();
        // locationUtils.LocationUtils().getLocationUpdates();
      });
    });
  }
}