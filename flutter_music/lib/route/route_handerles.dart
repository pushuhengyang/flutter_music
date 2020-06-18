import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

import '../pages/splash/splashPage.dart';
import '../pages/home/homePage.dart';
import '../pages/login/loginPage.dart';
import '../pages/find/findPage.dart';
import '../pages/video/videoPage.dart';
import '../pages/cloudcop/cloudcopPage.dart';
import '../pages/mine/minePage.dart';
import '../pages/user/userPage.dart';

var splashHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parms) {
  return SplashPage();
});

var homeHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parms) {
  return HomePage();
});

var LoginHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parms) {
  return LoginPage();
});

var FindHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parms) {
  return FindPage();
});

var VideoHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parms) {
  return VideoPage();
});

var CloudCopHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parms) {
  return CloudCop();
});

var MineHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parms) {
  return MinePage();
});

var UserHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parms) {
  return UserPage();
});
