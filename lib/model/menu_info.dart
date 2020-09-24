import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock/data/enum.dart';

class MenuInfo extends ChangeNotifier {
  MenuType menuType;
  String title;
  IconData icon;

  MenuInfo(this.menuType, {this.title, this.icon});

  updateMenuInfo(MenuInfo menuInfo) {
    this.menuType = menuInfo.menuType;
    this.title = menuInfo.title;
    this.icon = menuInfo.icon;
    // notifying all consumer listing it
    notifyListeners();
  }
}
