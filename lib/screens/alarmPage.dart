import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock/constants/color.dart';
import 'package:flutter_clock/dbHelper/dbHelper.dart';
import 'package:flutter_clock/main.dart';
import 'package:flutter_clock/model/alarm_info.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  Future<List<AlarmInfo>> _alarms;
  List<AlarmInfo> _currentAlarms;

  DateTime _alarmTime;
  String _alarmTimeString;

  DatabaseHelper databaseHelper = DatabaseHelper();

  void getAlarms() {
    _alarms = databaseHelper.queryAll();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _alarmTime = DateTime.now();
    super.initState();
    getAlarms();
  }

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
            child: FutureBuilder<List<AlarmInfo>>(
              future: _alarms,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  _currentAlarms = snapshot.data;
                  return ListView(
                    physics: BouncingScrollPhysics(),
                    children: snapshot.data
                        .map<Widget>((alarm) => _buildAlarmTile(alarm))
                        .followedBy([
                      if (_currentAlarms.length < 10)
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
                              onPressed: showBottomSheetforAlarm,
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
                      else
                        Center(
                          child: Text(
                            "Only  Ten Alarms Allowed",
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                        ),
                    ]).toList(),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  scheduleAlarm(DateTime scheduleAlarmDateTime, AlarmInfo alarmInfo) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm notification',
      'alarm notification',
      'Channel for alarm notification',
      icon: 'clocklogo',
      sound: RawResourceAndroidNotificationSound('alarm'),
      // sound: RawResourceAndroidNotificationSound('slow_spring_board'),
      largeIcon: DrawableResourceAndroidBitmap('clocklogo'),
    );

    var iosPlatforChannelSpecifics = IOSNotificationDetails(
      sound: 'soundname',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    var platformChannelSpecifies = NotificationDetails(
        androidPlatformChannelSpecifics, iosPlatforChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(0, 'Office',
        alarmInfo.alarmTitle, scheduleAlarmDateTime, platformChannelSpecifies);
  }

  Widget _buildAlarmTile(AlarmInfo alarm) {
    var formatedTime = DateFormat('hh:mm aa').format(alarm.alarmDateTime);
    var gradientColor =
        GradientTemplate.gradientTemplate[alarm.gradientColorIndex].color;
    return Container(
      margin: const EdgeInsets.only(bottom: 30.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColor ?? GradientColors.fire,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(24.0),
          boxShadow: [
            BoxShadow(
              color: gradientColor.last.withOpacity(0.4),
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
                    alarm.alarmTitle,
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
                formatedTime.toString(),
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 26.0,
                  ),
                  onPressed: () {
                    deleteAlarm(alarm.id);
                  })
            ],
          ),
        ],
      ),
    );
  }

  void onSaveAlarm() {
    DateTime scheduleAlarmDateTime;
    if (_alarmTime.isAfter(DateTime.now()))
      scheduleAlarmDateTime = _alarmTime;
    else
      scheduleAlarmDateTime = _alarmTime.add(Duration(days: 1));

    var alarmInfo = AlarmInfo(
      alarmDateTime: scheduleAlarmDateTime,
      gradientColorIndex: _currentAlarms.length,
      alarmTitle: 'alarm',
    );
    print("going to save ");
    databaseHelper.insert(alarmInfo);
    scheduleAlarm(scheduleAlarmDateTime, alarmInfo);
    Navigator.pop(context);
    getAlarms();
  }

  void showBottomSheetforAlarm() {
    _alarmTimeString = DateFormat('hh:mm aa').format(DateTime.now());
    showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  FlatButton(
                    onPressed: () async {
                      var selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (selectedTime != null) {
                        final now = DateTime.now();
                        var selectedDateTime = DateTime(now.year, now.month,
                            now.day, selectedTime.hour, selectedTime.minute);
                        _alarmTime = selectedDateTime;
                        setModalState(() {
                          _alarmTimeString =
                              DateFormat('hh:mm aa').format(selectedDateTime);
                        });
                      }
                    },
                    child: Text(
                      _alarmTimeString,
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                  ListTile(
                    title: Text('Repeat'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    title: Text('Sound'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    title: Text('Title'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  FloatingActionButton.extended(
                    onPressed: onSaveAlarm,
                    icon: Icon(Icons.alarm),
                    label: Text('Save'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void deleteAlarm(int id) async {
    await databaseHelper.delete(id);
    getAlarms();
    //logic for unsubscribing alarm
    // use local notification plugin and use id there
  }
}
