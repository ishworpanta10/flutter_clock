import 'package:flutter/material.dart';
import 'package:flutter_clock/constants/color.dart';
import 'package:flutter_clock/data/data.dart';
import 'package:flutter_clock/data/enum.dart';
import 'package:flutter_clock/model/menu_info.dart';
import 'package:flutter_clock/screens/alarmPage.dart';
import 'package:flutter_clock/screens/clockPage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.pageBackgroundColor,
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems
                .map((menuItem) => buildMenuButton(currentMenuInfo: menuItem))
                .toList(),
          ),
          VerticalDivider(
            color: Colors.white54,
            width: 1,
          ),
          Expanded(
            child: Consumer<MenuInfo>(
                builder: (BuildContext context, MenuInfo value, Widget child) {
              if (value.menuType == MenuType.alarm) {
                return AlarmPage();
              } else if (value.menuType == MenuType.clock) {
                return ClockPage();
              } else if (value.menuType == MenuType.timer) {
                Center(
                  child: Text(
                    value.title,
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              return Center(
                child: Text(
                  value.title,
                  style: TextStyle(color: Colors.white),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget buildMenuButton({MenuInfo currentMenuInfo}) {
    return Consumer<MenuInfo>(
      builder: (BuildContext context, MenuInfo value, Widget child) {
        return FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(32),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          color: currentMenuInfo.menuType == value.menuType
              ? Colors.blueGrey
              : Colors.transparent,
          onPressed: () {
            var menuInfo = Provider.of<MenuInfo>(context, listen: false);
            menuInfo.updateMenuInfo(currentMenuInfo);
          },
          child: Column(
            children: [
              Icon(
                currentMenuInfo.icon,
                color: Colors.white,
                size: 34.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                currentMenuInfo.title,
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
            ],
          ),
        );
      },
    );
  }
}
