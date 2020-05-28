import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'route_handerles.dart';

class Routes {
  static String root = '/';
  static String homt = "/home";

  static void configureRoutes(Router router) {
    router.notFoundHandler =
        Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parms) {
      print("ROUTE WAS NOT FOUND !!!");
      return Container();
    });
    router.define(root, handler: splashHandler);
    router.define(homt, handler: homeHandler);
  }
}
