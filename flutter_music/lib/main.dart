import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:fluttermusic/application.dart';
import 'package:fluttermusic/model/userModel.dart';
import 'package:fluttermusic/pages/splash/splashPage.dart';
import 'package:fluttermusic/pages/home/homePage.dart';
import 'package:fluttermusic/pages/login/loginPage.dart';
import 'package:event_bus/event_bus.dart';
import 'package:fluttermusic/tools/tools.dart';
import 'package:fluttermusic/tools/netHander.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // 初始化
  AppLication.shareIndex();
  ScreenUtil.getInstance();
  NetHander.standIndex();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
      onGenerateRoute: AppLication.router.generator,
    );
  }
}
