import 'package:flutter/material.dart';
import 'package:fluttermusic/application.dart';
import 'package:fluttermusic/tools/colorTool.dart';
import 'package:fluttermusic/widgets/comentwidgets.dart';
import 'dart:async';

import 'package:fluttermusic/widgets/custom_netimage.dart';

/// 封装的轮播图
class CustomBanner extends StatefulWidget {
  final List<String> _images;
  final double height;
  final ValueChanged<int> onTap;
  final Curve curve;
  final IndexedWidgetBuilder itemBuild;

  CustomBanner(this._images,
      {this.height = 200, this.onTap, this.curve = Curves.linear, this.itemBuild})
      : assert(_images != null);

  @override
  _CustomBannerState createState() => _CustomBannerState();
}

class _CustomBannerState extends State<CustomBanner> {
  PageController _pageController;
  int _curIndex;
  Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final count = widget._images.length;
    if (count <= 1) {
      _curIndex = 0;
    } else {
      _curIndex = count * 5;
      _initTimer();
    }
    _pageController = PageController(initialPage: _curIndex);
  }

  _initTimer() {
    if (widget._images.length <= 1) return;
    if (_timer == null && mounted) {
      _timer = Timer.periodic(Duration(seconds: 3), _timerChange);
    }
  }

  /// 点击到图片的时候取消定时任务
  _cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
      _initTimer();
    }
  }

  /// 定时器
  void _timerChange(Timer timer) {
    final count = widget._images.length;
    if (count <= 1) return;
    if (_curIndex <= count * 45) {
      _curIndex += 1;
      _pageController
          .animateToPage(_curIndex,
              duration: Duration(milliseconds: 500), curve: widget.curve)
          .then((value) => {this.setState(() {})});
    } else {
      _curIndex = count * 5;

      _pageController.jumpToPage(_curIndex);
      _timerChange(timer);
    }
  }

  Widget _pageViewBuild() {
    final length = widget._images.length;
    final double wid = AppLication.screen_width - 15 * 2;
    final double hig = wid * 21.0 / 54.0;
    return Container(
      height: hig,
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        controller: _pageController,
        itemBuilder: (context, index) {
          return GestureDetector(
            onPanDown: (datel) {
              _cancelTimer();
            },
            child: _itemBuild(context, index),
            onTap: () => widget.onTap,
          );
        },
        onPageChanged: (index) {
          if (_curIndex != index) {
            _pageChange(index);
          }
        },
      ),
    );
  }

  Widget _itemBuild(BuildContext context, int index) {
    final length = widget._images.length;
    final int tem = index % length;
    if (widget.itemBuild != null) return widget.itemBuild(context, tem);
    return CustomNetImage(
      widget._images[index],
      fit: BoxFit.fitWidth,
    );
  }

  ///  滑动page来更改
  _pageChange(int index) {
    final count = widget._images.length;
    if (count <= 1) return;
    if (index <= count * 45 && index >= count * 5) {
      setState(() {
        _curIndex = index;
      });
    } else {
      _curIndex = count * 5 + index % count;
      _pageController.jumpToPage(index);
      setState(() {});
    }
  }

  ///标志
  Widget _indicatorBuild() {
    final count = widget._images.length;
    List<int> indiList = List.generate(widget._images.length, (index) => index);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: indiList.map((e) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
                color: e == _curIndex % count ? NormThemColor : Colors.grey,
                borderRadius: BorderRadius.circular(4)),
            margin: EdgeInsets.symmetric(horizontal: 4),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        _pageViewBuild(),
        Positioned(
          child: _indicatorBuild(),
          bottom: 10,
        ),
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }
}
