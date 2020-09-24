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
              FlatButton(
                  onPressed: () {},
                  child: Column(
                    children: [
                      FlutterLogo(),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Clock",
                        style: TextStyle(color: Colors.white, fontSize: 14.0),
                      ),
                    ],
                  ))
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Clock",
                    style: TextStyle(fontSize: 24.0, color: Colors.white),
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  Text(
                    formatedTime,
                    style: TextStyle(fontSize: 64.0, color: Colors.white),
                  ),
                  Text(
                    formatedDate,
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  ClockView(),
                  Text(
                    "Timezone",
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
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
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
