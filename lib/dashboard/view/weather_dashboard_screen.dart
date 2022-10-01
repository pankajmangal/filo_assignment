import 'package:filo_assignment/dashboard/controller/weather_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeatherDashboardScreen extends StatelessWidget {
  WeatherDashboardScreen({Key? key}) : super(key: key);

  final WeatherController _weatherController = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }
}
