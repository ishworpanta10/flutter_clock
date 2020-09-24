import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clock/data/enum.dart';
import 'package:flutter_clock/model/menu_info.dart';

List<MenuInfo> menuItems = [
  MenuInfo(MenuType.clock, title: 'Clock', icon: Icons.access_alarm),
  MenuInfo(MenuType.alarm, title: 'Alarm', icon: Icons.alarm_add),
  MenuInfo(MenuType.timer, title: 'Timer', icon: Icons.timer),
  MenuInfo(MenuType.stopwatch, title: 'Stopwatch', icon: Icons.access_time),
];
