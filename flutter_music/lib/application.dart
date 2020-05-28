import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:fluro/fluro.dart';
import 'package:flustars/flustars.dart';

import 'route/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:event_bus/event_bus.dart';

typedef MsgCallback = void Function(dynamic msg);

class AppLication {
  static Router router;
  static SharedPreferences sp;
  static EventBus _eventbus;
  static ScreenUtil _screenUtil;

  static shareIndex() async {
    _eventbus = EventBus();
    router = Router();
    _screenUtil = ScreenUtil.getInstance();
    sp = await SharedPreferences.getInstance();
    Routes.configureRoutes(router);
  }

  static sendMessage(String key, {dynamic msg = ""}) {
    assert(key != null, "key is  null");
    _eventbus.fire({key: msg});
  }

  static addListion(String key, MsgCallback message) {
    assert(key != null, "key is  null");
    _eventbus.on().listen((event) {
      if (!(event is Map)) return;
      Map msg = event;
      if (msg.keys.first == key) {
        message(msg[key]);
      }
    });
  }

  static get screen_width => _screenUtil.screenWidth;
  static get screen_hight => _screenUtil.screenHeight;
  static get statusBarHight => _screenUtil.statusBarHeight;
  static get bottomBarHight => _screenUtil.bottomBarHeight;
}
