import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

import '../pages/splash/splashPage.dart';
import '../pages/home/homePage.dart';

var splashHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parms) {
  return SplashPage();
});

var homeHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parms) {
  return HomePage();
});
