import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:fluttermusic/application.dart';
import 'package:fluttermusic/pages/splash/splashPage.dart';
import 'package:fluttermusic/pages/home/homePage.dart';
import 'package:fluttermusic/pages/login/loginPage.dart';
import 'package:event_bus/event_bus.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // 初始化
  AppLication.shareIndex();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int rootFlg = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppLication.addListion("root_Flg", (msg) {
      if (rootFlg != msg) {
        setState(() {
          rootFlg = msg;
        });
      }
    });
  }

  Widget _getRootPage() {
    if (rootFlg == 0) {
      return SplashPage();
    } else if (rootFlg == 1) {
      return LoginPage();
    } else {
      return HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.getInstance();
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: _getRootPage(),
      onGenerateRoute: AppLication.router.generator,
    );
  }
}
