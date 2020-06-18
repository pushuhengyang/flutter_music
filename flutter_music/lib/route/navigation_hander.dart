import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:fluttermusic/application.dart';
import 'package:fluttermusic/route/routes.dart';

class NavigationHander {
  static _navigateTo(BuildContext context, String path,
      {bool replace = false,
      bool clearStack = false,
      Duration transitionDuration = const Duration(milliseconds: 250),
      RouteTransitionsBuilder transitionBuilder}) {
    AppLication.router.navigateTo(context, path,
        replace: replace,
        clearStack: clearStack,
        transitionDuration: transitionDuration,
        transitionBuilder: transitionBuilder,
        transition: TransitionType.cupertino);
  }

  /// 首页
  static goHomePage(BuildContext context) {
    _navigateTo(context, Routes.home, clearStack: true);
  }

  /// 登录页面
  static goLoginPage(BuildContext context) {
    _navigateTo(context, Routes.login, clearStack: true);
  }
}
