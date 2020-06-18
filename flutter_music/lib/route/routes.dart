import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'route_handerles.dart';

class Routes {
  static String root = '/';
  static String login = "/login";
  static String home = "/home";

  static String find = "/find";
  static String video = "/video";
  static String mine = "/mine";
  static String cloud = "/cloud";
  static String user = "/user";

  static void configureRoutes(Router router) {
    router.notFoundHandler =
        Handler(handlerFunc: (BuildContext context, Map<String, List<String>> parms) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: Center(
          child: Text("ROUTE WAS NOT FOUND !!!"),
        ),
      );
    });
    router.define(root, handler: splashHandler);
    router.define(home, handler: homeHandler);
    router.define(login, handler: LoginHandler);
    router.define(find, handler: FindHandler);
    router.define(video, handler: VideoHandler);
    router.define(cloud, handler: CloudCopHandler);
    router.define(mine, handler: MineHandler);
    router.define(user, handler: UserHandler);
  }
}
