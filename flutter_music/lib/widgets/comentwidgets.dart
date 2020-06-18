import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 横向空视图
class HEmptyView extends StatelessWidget {
  final double width;

  HEmptyView(this.width);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}

/// 纵向空视图
class VEmptyView extends StatelessWidget {
  final double height;

  VEmptyView(this.height);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

/// 一个有border 的控件
class CustomBorderWidget extends StatelessWidget {
  final double borderWidth;
  final Color borderColor;
  final Widget child;
  final double radius;
  final double width;
  final double height;
  final AlignmentGeometry alignment;

  CustomBorderWidget(
      {this.borderColor = Colors.grey,
      this.borderWidth = 1,
      this.child,
      this.radius = 5,
      this.width,
      this.height,
      this.alignment = Alignment.center});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      width: width,
      height: height,
      child: child,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border:
              Border.fromBorderSide(BorderSide(width: borderWidth, color: borderColor))),
    );
  }
}
