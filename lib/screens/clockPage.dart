import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clock/screens/clockView.dart';
import 'package:intl/intl.dart';

class ClockPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formatedDate = DateFormat('EEE, d MMM y').format(now);
    var timeZoneOffset = now.timeZoneOffset.toString().split('.').first;
    var offsetSign = '';
    if (!timeZoneOffset.startsWith('-')) offsetSign = '+';
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                DigitalClockWidget(),
                SizedBox(
                  height: 10.0,
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
  }
}

class DigitalClockWidget extends StatefulWidget {
  @override
  _DigitalClockWidgetState createState() => _DigitalClockWidgetState();
}

class _DigitalClockWidgetState extends State<DigitalClockWidget> {
  var formatedTime = DateFormat('hh:mm aa').format(DateTime.now());

  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      var previousMinute = DateTime.now().add(Duration(seconds: -1)).minute;
      var currentMinute = DateTime.now().minute;
      print(previousMinute.toString());
      print(currentMinute.toString());

      if (previousMinute != currentMinute)
        setState(() {
          formatedTime = DateFormat('hh:mm aa').format(DateTime.now());
        });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        formatedTime,
        style: TextStyle(
            // fontWeight: FontWeight.w500,
            fontSize: 54.0,
            color: Colors.white),
      ),
    );
  }
}
