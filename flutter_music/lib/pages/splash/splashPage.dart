import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';
import 'package:fluttermusic/application.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController _logoController;
  Tween _scaleTween;
  CurvedAnimation _logoAnimation;
  @override
  void initState() {
    // TODO: implement initStat
    super.initState();
    _scaleTween = Tween(begin: 0, end: 1);
    _logoController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..drive(_scaleTween);
    Future.delayed(Duration(milliseconds: 250), () {
      _logoController.forward();
    });
    _logoAnimation = CurvedAnimation(parent: _logoController, curve: Curves.easeInOut);
    _logoController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(milliseconds: 250), () {
          AppLication.sendMessage("root_Flg", msg: 1);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: ScaleTransition(
          scale: _logoAnimation,
          child: Hero(
            tag: "logo",
            child: Image.asset(
              "image/icon_logo.png",
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _logoController.dispose();
  }
}
