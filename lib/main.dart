import 'package:flutter/material.dart';
import 'package:flutter_clock/data/enum.dart';
import 'package:flutter_clock/model/menu_info.dart';
import 'package:flutter_clock/screens/homePage.dart';
import 'package:provider/provider.dart';

void main() {
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
