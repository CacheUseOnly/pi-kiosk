import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key});

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  int temperature = 0;

  void getForecastData() {
    Map<String, dynamic> buffer;
    Duration next = const Duration(minutes: 5);

    http
        .get(Uri.parse(
            "https://api.weather.gov/gridpoints/OKX/32,35/forecast?units=si"))
        .then((res) {
      buffer = jsonDecode(res.body) as Map<String, dynamic>;
      setState(() {
        temperature = buffer['properties']['periods'][0]['temperature'];
      });
      next = DateTime.parse(buffer['properties']['periods'][0]['endTime'])
          .difference(DateTime.now());
      Timer(next, getForecastData);
    });
    // Retry in 5 minutes if error
    Timer(next, getForecastData);
  }

  @override
  void initState() {
    getForecastData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "$temperature°C",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
