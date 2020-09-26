import 'package:flutter/material.dart';
import 'package:flutter_clock/data/enum.dart';
import 'package:flutter_clock/model/alarm_info.dart';
import 'package:flutter_clock/model/menu_info.dart';

List<MenuInfo> menuItems = [
  MenuInfo(MenuType.clock, title: 'Clock', icon: Icons.access_alarm),
  MenuInfo(MenuType.alarm, title: 'Alarm', icon: Icons.alarm_add),
  MenuInfo(MenuType.timer, title: 'Timer', icon: Icons.timer),
  MenuInfo(MenuType.stopwatch, title: 'Stopwatch', icon: Icons.access_time),
];

List<AlarmInfo> alarmList = [
  AlarmInfo(
    alarmDateTime: (DateTime.now().add(Duration(hours: 1))),
    alarmTitle: "Morning Alarm",
    gradientColorIndex: 0,
  ),
  AlarmInfo(
    alarmDateTime: (DateTime.now().add(Duration(hours: 1))),
    alarmTitle: "Evening Alarm",
    gradientColorIndex: 1,
  ),
  AlarmInfo(
    alarmDateTime: (DateTime.now().add(Duration(hours: 1))),
    alarmTitle: "Demog Alarm",
    gradientColorIndex: 2,
  ),
];
