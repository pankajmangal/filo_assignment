import 'package:app_settings/app_settings.dart';
import 'package:filo_assignment/custom_views/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  static final PermissionUtils _locationUtils = PermissionUtils._internal();

  factory PermissionUtils() => _locationUtils;

  PermissionUtils._internal();

  askForPermission(PermissionWithService permission, {required Function onGranted}) async{
    print('####====> askForPermission() called');
    await checkPermission(permission, (int type) {
      if (type == 1) {
        // Permission Granted
        onGranted();
      } else if (type == 2) {
        // Permission Denied
        showPermissionDialog(
            title: 'Enable Permission',
            description:
                'You need to enable location permission in order to access App Functionality',
            onClick: () {
              askForPermission(permission, onGranted: onGranted);
            });
      } else if (type == 3) {
        // Permission Permanently Denied. Open Settings.
        showPermissionDialog(
            title: 'Open Settings',
            description:
                'You need to enable location permission from Settings in order to access App Functionality',
            onClick: () async{
              await openSettings(permission);
            });
      }
    });
  }

  checkPermission(PermissionWithService permission, Function onResult) async {
    print('####====> checkPermission() called');
    var status = await permission.status;
    print('####====> $status called :: ${permission.serviceStatus}');
    if (status.isGranted) {
      onResult(1);
    } else if (status.isPermanentlyDenied) {
      onResult(3);
    } else {
      status = await permission.request();
      if (status.isGranted) {
        onResult(1);
      } else if (status.isPermanentlyDenied) {
        onResult(3);
      } else {
        onResult(2);
      }
    }
  }

  openSettings(Permission permission) async {
    await AppSettings.openLocationSettings();
  }

  void showPermissionDialog({title, description, required Function onClick, context}) =>
      Get.dialog(CustomAlertDialog(
        btn1: title,
        str: description,
        onClick: () {
          Get.back();
          // FocusScope.of(context).requestFocus(FocusNode());
          onClick();
        }, onClick2: (){},));

  Future<bool> _onWillPop() async {
    // NavigationService().popUntil();
    return true;
  }
}