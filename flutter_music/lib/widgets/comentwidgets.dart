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


