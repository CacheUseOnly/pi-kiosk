import 'package:flutter/material.dart';

import '../Components/clock.dart';
import '../Components/weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(flex: 4, child: WeatherWidget()),
            VerticalDivider(
              width: 15,
              indent: 20,
              endIndent: 20,
              color: Colors.grey,
            ),
            Expanded(flex: 6, child: ClockWidget()),
          ],
        ),
      ),
    );
  }
}
