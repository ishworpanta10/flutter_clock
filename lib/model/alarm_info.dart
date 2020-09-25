import 'package:flutter/material.dart';

class AlarmInfo {
  DateTime alarmDateTime;
  String alarmDescription;
  bool isActive;
  List<Color> gradientColors;

  AlarmInfo(this.alarmDateTime,
      {this.alarmDescription, this.isActive, this.gradientColors});
}
