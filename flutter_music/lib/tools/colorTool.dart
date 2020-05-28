import 'package:flutter/material.dart';

class ColorTools {
  static Color hexColor(String hexStr, {double alpha = 1}) {
    assert(hexStr != null, "十六进制字符串不能为空");
    assert(hexStr.length >= 6, "最低六位数字");
    if (hexStr.substring(0, 1) == "#") {
      hexStr = hexStr.substring(1);
    }
    int hex = int.parse(hexStr, radix: 16);
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    return Color.fromRGBO(
        (hex & 0xFF0000) >> 16, (hex & 0x00FF00) >> 8, (hex & 0x0000FF) >> 0, alpha);
  }
}
