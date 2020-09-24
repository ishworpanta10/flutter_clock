import 'package:flutter/material.dart';
import 'package:flutter_clock/screens/clockView.dart';
import 'package:intl/intl.dart';

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
            children: [
              buildMenuButton(icon: Icons.access_alarm, title: 'Clock'),
              buildMenuButton(icon: Icons.alarm_add, title: 'Alarm'),
              buildMenuButton(icon: Icons.timer, title: 'Timer'),
              buildMenuButton(icon: Icons.access_time, title: 'Stopwatch'),
            ],
          ),
          VerticalDivider(
            color: Colors.white54,
            width: 1,
          ),
          Expanded(
            child: Container(
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
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuButton({String title, IconData icon}) {
    return FlatButton(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      onPressed: () {},
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 34.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}
