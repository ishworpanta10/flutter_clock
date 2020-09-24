import 'package:flutter/material.dart';
import 'package:flutter_clock/data/data.dart';
import 'package:flutter_clock/data/enum.dart';
import 'package:flutter_clock/model/menu_info.dart';
import 'package:flutter_clock/screens/clockView.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formatedDate = DateFormat('EEE, d MMM y').format(now);
    var formatedTime = DateFormat('hh:mm').format(now);
    var timeZoneOffset = now.timeZoneOffset.toString().split('.').first;
    var offsetSign = '';
    if (!timeZoneOffset.startsWith('-')) offsetSign = '+';

    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
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
              if (value.menuType != MenuType.clock) {
                return Center(
                  child: Text("Other"),
                );
              }
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Text(
                        "Clock",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24.0,
                            color: Colors.white),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            formatedTime,
                            style: TextStyle(
                                // fontWeight: FontWeight.w500,
                                fontSize: 64.0,
                                color: Colors.red),
                          ),
                          Text(
                            formatedDate,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20.0,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.center,
                        child: ClockView(
                          size: MediaQuery.of(context).size.height / 4,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Timezone",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20.0,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.language,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Text(
                                "UTC " + offsetSign + timeZoneOffset,
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 18.0,
                                    color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
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
