import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermusic/pages/cloudcop/cloudcopPage.dart';
import 'package:fluttermusic/pages/find/findPage.dart';
import 'package:fluttermusic/pages/mine/minePage.dart';
import 'package:fluttermusic/pages/user/userPage.dart';
import 'package:fluttermusic/pages/video/videoPage.dart';
import 'package:fluttermusic/route/routes.dart';
import 'package:fluttermusic/application.dart';
import 'package:fluttermusic/tools/colorTool.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BottomNavigationBarItem _tabBarItem(IconData data, String title) {
    return BottomNavigationBarItem(icon: Icon(data), title: Text(title));
  }

  List<BottomNavigationBarItem> _tabbarItems() {
    return [
      _tabBarItem(Icons.home, "发现"),
      _tabBarItem(Icons.video_library, "视频"),
      _tabBarItem(Icons.music_video, "我的"),
      _tabBarItem(Icons.people, "云村"),
      _tabBarItem(Icons.person, "账号"),
    ];
  }

  ///这里可以做个
  Widget _tabPage(BuildContext context, int index) {
    if (index == 0) return FindPage();
    if (index == 1) return VideoPage();
    if (index == 2) return MinePage();
    if (index == 3) return CloudCop();
    if (index == 4) return UserPage();
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              items: _tabbarItems(),
              activeColor: NormThemColor,
            ),
            tabBuilder: _tabPage,
          ),
          Positioned(
            top: AppLication.statusBarHight - 44,
            right: 20,
            width: 40,
            height: 40,
            child: FlatButton(
              child: Icon(
                Icons.music_note,
                color: NormTitleColor,
              ),
              onPressed: () {},
            ),
          ),
        ],
      )),
    );
  }
}
