import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock/constants/color.dart';
import 'package:flutter_clock/data/data.dart';
import 'package:flutter_clock/model/alarm_info.dart';

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 64.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Alarm",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24.0,
                color: Colors.white),
          ),
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: alarmList
                  .map<Widget>((alarm) => _buildAlarmTile(alarm))
                  .followedBy([
                DottedBorder(
                  strokeWidth: 3,
                  borderType: BorderType.RRect,
                  radius: Radius.circular(24.0),
                  color: Colors.white,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      color: CustomColors.clockBG,
                    ),
                    child: FlatButton(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 16.0),
                      onPressed: () {},
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/iconPlus.png',
                            color: Colors.blue,
                            scale: 1.5,
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            "Add Alarm",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ]).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAlarmTile(AlarmInfo alarm) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: alarm.gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(24.0),
          boxShadow: [
            BoxShadow(
              color: alarm.gradientColors.last.withOpacity(0.4),
              blurRadius: 8.0,
              spreadRadius: 4,
              offset: Offset(4, 4),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.alarm,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    alarm.alarmDescription,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Switch(
                value: true,
                onChanged: (value) {},
                activeColor: Colors.white,
              )
            ],
          ),
          Text(
            "Mon-Fri",
            style: TextStyle(color: Colors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "07:00 AM",
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
                size: 30.0,
              )
            ],
          ),
        ],
      ),
    );
  }
}
