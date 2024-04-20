import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClockWidget extends StatefulWidget {
  const ClockWidget({ super.key });

  @override
  State<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  String _timeString = "";
  String _dateString = "";
  
  void _getCurrentTime() {
    DateTime now = DateTime.now();
    setState(() {
      _timeString = DateFormat('kk:mm').format(now);
      _dateString = DateFormat('EEE - MM/dd').format(now);
    });
  }
  
  @override
  void initState() {
    DateTime now = DateTime.now();
    _timeString = DateFormat('kk:mm').format(now);
    _dateString = DateFormat('EEE - MM/dd').format(now);
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getCurrentTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            Text(
              _timeString,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(_dateString),
          ],)
        ),
    );
  }
}