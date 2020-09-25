import 'package:flutter/material.dart';
import 'package:flutter_clock/data/enum.dart';
import 'package:flutter_clock/model/menu_info.dart';
import 'package:flutter_clock/screens/homePage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  // for local notification
  WidgetsFlutterBinding.ensureInitialized();
  var initalizationSettingsAndroid = AndroidInitializationSettings('clocklogo');
  var initailizationSettingsIos = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String title, String bbody, String payload) async {});
  var initializationSettings = InitializationSettings(
      initalizationSettingsAndroid, initailizationSettingsIos);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    debugPrint('notification payload: ' + payload);
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Clock",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider<MenuInfo>(
        create: (_) => MenuInfo(MenuType.clock),
        child: HomePage(),
      ),
    );
  }
}
