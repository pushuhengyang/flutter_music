import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';

///发现

import 'package:flutter/material.dart';
import 'package:fluttermusic/application.dart';
import 'package:fluttermusic/model/bannermodel.dart';
import 'package:fluttermusic/model/songsheetModel.dart';
import 'package:fluttermusic/tools/colorTool.dart';
import 'package:fluttermusic/tools/netHander.dart';
import 'package:fluttermusic/widgets/comentwidgets.dart';
import 'package:fluttermusic/widgets/custom_banner.dart';
import 'package:fluttermusic/widgets/custom_futurebuilder.dart';
import 'package:fluttermusic/widgets/custom_netimage.dart';

class FindPage extends StatefulWidget {
  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  ///导航栏
  CupertinoNavigationBar _naviBar(BuildContext context) {
    return CupertinoNavigationBar(
      leading: IconButton(
          icon: Icon(
            Icons.settings_voice,
            size: 28,
            color: NormTitleColor,
          ),
          onPressed: null),
      middle: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(18)), color: NormSectionColor),
        height: 35,
        margin: EdgeInsets.only(left: 10, right: 60),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.search,
              color: NormSubTitLeColor,
            ),
            Text(
              "天才啊",
              style: TextStyle(color: NormSubTitLeColor),
            ),
          ],
        ),
      ),
      border: Border(),
    );
  }

  ///banner 视图
  Widget _bannerWidget() {
    final double wid = AppLication.screen_width - 15 * 2;
    final double hig = wid * 21.0 / 54.0;
    return CustomFutureBuilder<BannerModel>(
        futureFunc: NetHander.getBannerData,
        builder: (context, data) {
          List<String> imgs = data.banners.map((e) => "${e.pic}?param=540y210").toList();
          return CustomBanner(
            imgs,
            height: hig,
            itemBuild: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                margin: EdgeInsets.zero,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CustomNetImage(
                    imgs[index],
                    fit: BoxFit.fitWidth,
                  ),
                ),
              );
            },
          );
        });
  }

  /// 功能  视图
  Widget _funcWidget() {
    final Map<String, String> icons = {
      '每日推荐': 'images/icon_daily.png',
      '歌单': 'images/icon_playlist.png',
      '排行榜': 'images/icon_rank.png',
      '电台': 'images/icon_radio.png',
      '直播': 'images/icon_look.png',
      '数字专辑': 'images/icon_look.png',
    };

    final double itemW = 60;
    final double rat = 1.3;
    final double itemH = itemW * rat;

    return Container(
      height: itemH,
      child: GridView.builder(
          itemCount: 6,
          padding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10, crossAxisCount: 1, childAspectRatio: 1.2),
          itemBuilder: (context, index) {
            final key = icons.keys.toList()[index];
            return GestureDetector(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    child: Image.asset(
                      icons[key],
                      width: 35,
                      height: 35,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.red, borderRadius: BorderRadius.circular(30)),
                    margin: EdgeInsets.only(bottom: 5),
                  ),
                  Text(
                    key,
                    style: NormSubStyle,
                  ),
                ],
              ),
              onTap: () {
                print("key = ${key}");
              },
            );
          }),
    );
  }

  /// 宝藏歌单
  Widget _trueSongsWidget() {
    return CustomFutureBuilder<SongSheetModel>(
        futureFunc: NetHander.getHotSongSheetData,
        builder: (context, data) {
          final count = (data.playlists != null) ? data.playlists.length : 0;
          final double wid = 110;
          final double hig = 170;
          final double rat = hig / wid;
          return Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "发现好歌单",
                      style: TextStyle(color: NormTitleColor, fontSize: 25),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: CustomBorderWidget(
                        radius: 12,
                        borderColor: NormSubTitLeColor,
                        width: 90,
                        child: Text(
                          "查看更多",
                          style: TextStyle(color: NormSubTitLeColor, fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: hig,
                child: GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    itemCount: count,
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1, mainAxisSpacing: 10, childAspectRatio: rat),
                    itemBuilder: (context, index) {
                      final Playlist play = data.playlists[index];
                      return Column(
                        children: <Widget>[
                          Container(
                            child: Stack(
                              children: <Widget>[
                                CustomNetImage(
                                  play.coverImgUrl,
                                  fit: BoxFit.fitWidth,
                                  width: wid,
                                  height: wid,
                                ),
                              ],
                            ),
                          ),
                          VEmptyView(5),
                          Text(
                            play.name,
                            textAlign: TextAlign.start,
                            style: TextStyle(color: NormTitleColor, fontSize: 15),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      );
                    }),
              ),
            ],
          );
        });
  }

  /// 华语金曲
  Widget _langueRecomWidget() {
    return CustomFutureBuilder<SongSheetModel>(
        futureFunc: NetHander.getHotSongSheetData,
        builder: (context, data) {
          final count = (data.playlists != null) ? data.playlists.length : 0;
          final double wid = 110;
          final double hig = 170;
          final double rat = hig / wid;
          return Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "华语金曲点唱机",
                      style: TextStyle(color: NormTitleColor, fontSize: 25),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: CustomBorderWidget(
                        radius: 12,
                        borderColor: NormSubTitLeColor,
                        width: 90,
                        child: CustomBorderWidget(
                          width: 120,
                          radius: 12,
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.play_arrow,
                                color: NormTitleColor,
                                size: 18,
                              ),
                              Text(
                                "播放全部",
                                style: TextStyle(color: NormSubTitLeColor, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              VEmptyView(20),
              Container(
                height: hig,
                child: GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    itemCount: count,
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1, mainAxisSpacing: 10, childAspectRatio: rat),
                    itemBuilder: (context, index) {
                      final Playlist play = data.playlists[index];
                      return Column(
                        children: <Widget>[
                          Container(
                            child: Stack(
                              children: <Widget>[
                                CustomNetImage(
                                  play.coverImgUrl,
                                  fit: BoxFit.fitWidth,
                                  width: wid,
                                  height: wid,
                                ),
                              ],
                            ),
                          ),
                          VEmptyView(5),
                          Text(
                            play.name,
                            textAlign: TextAlign.start,
                            style: TextStyle(color: NormTitleColor, fontSize: 15),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      );
                    }),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: _naviBar(context),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            VEmptyView(54),
            _bannerWidget(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: _funcWidget(),
            ),
            _trueSongsWidget(),
            VEmptyView(10),
            _langueRecomWidget(),
            VEmptyView(40),
          ],
        ),
      ),
    );
  }
}
