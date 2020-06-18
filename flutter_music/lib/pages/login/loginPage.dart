import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermusic/model/userModel.dart';
import 'package:fluttermusic/route/navigation_hander.dart';
import 'package:fluttermusic/tools/colorTool.dart';
import 'package:fluttermusic/widgets/comentwidgets.dart';
import 'package:fluttermusic/widgets/normWidgets.dart';
import 'package:fluttermusic/application.dart';
import 'package:fluttermusic/tools/tools.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
    Future.delayed(Duration(milliseconds: 500), () {
      _controller.forward();
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.dispose();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 40, right: 40, top: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Hero(
                tag: "logo",
                child: Image.asset(
                  "image/icon_logo.png",
                  width: 50,
                  height: 50,
                ),
              ),
              VEmptyView(20),
              _LoginView(animation: _animation),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginView extends AnimatedWidget {
  final Tween<double> _opacityTween = Tween(begin: 0, end: 1);
  final Tween<double> _offsetTween = Tween(begin: 40, end: 0);
  final Animation animation;

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  _LoginView({@required this.animation}) : super(listenable: animation);

  ///点击登录
  void loginClick(BuildContext context) async {
    String phone = _phoneController.text;
    String psd = _pwdController.text;
    if (phone.isEmpty) {
      Hub.showToast("手机号不能为空！");
      return;
    }
    if (psd.isEmpty) {
      Hub.showToast("密码不能为空！");
      return;
    }
    Response res =
        await NetHander.userLoginWithParms({"phone": phone, "password": psd}, context);
    UserModel user = UserModel.fromJson(res.data);
    if (user.code == 200) {
      await UserTool.saveUserInfo(res.data);
      NavigationHander.goHomePage(context);
    } else {
      Hub.showToast(res.statusMessage);
    }
  }

  ///输入视图
  Widget _textFildWidget(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TextField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.phone_android,
                color: Colors.grey,
              ),
              hintMaxLines: 1,
              hintText: "Phone",
            ),
          ),
          VEmptyView(30),
          TextField(
            obscureText: true,
            controller: _pwdController,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.grey,
              ),
              hintMaxLines: 1,
              hintText: "Password",
            ),
          ),
          Container(
              width: AppLication.screen_width - 80,
              height: 56,
              margin: EdgeInsets.only(top: 100, left: 0, right: 0),
              child: CupertinoButton(
                  color: Colors.red,
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(26)),
                  onPressed: () => loginClick(context)))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _opacityTween.evaluate(animation),
      child: Container(
        margin: EdgeInsets.only(top: _offsetTween.evaluate(animation)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Welcome Back!",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 40, color: Colors.black),
            ),
            VEmptyView(10),
            Text(
              "The Flutter Project Music App!",
              style: TextStyle(
                color: ColorTools.hexColor("666666"),
                fontSize: 15,
              ),
              textAlign: TextAlign.left,
            ),
            VEmptyView(30),
            _textFildWidget(context),
          ],
        ),
      ),
    );
  }
}
