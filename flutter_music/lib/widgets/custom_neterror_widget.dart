import 'package:flutter/material.dart';
import 'package:fluttermusic/tools/colorTool.dart';
import 'package:fluttermusic/widgets/comentwidgets.dart';

class NetErrorWidget extends StatelessWidget {
  final VoidCallback callback;

  NetErrorWidget({@required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        alignment: Alignment.center,
        height: 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.error_outline,
              size: 80,
            ),
            VEmptyView(10),
            Text(
              '点击重新请求',
              style: NormTitleStyle,
            )
          ],
        ),
      ),
    );
  }
}
