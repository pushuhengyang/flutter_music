///网络库
import 'package:dio/dio.dart';

class NetHander {
  static final _netHander = NetHander();
  static Dio _dio = Dio();
  static String _baseurl = "http://localhost:3000";

  static NetHander standIndex() {
    _netHander._init();
    return _netHander;
  }

  _init() {}

  ///post 请求
  static Future<Response> postNetSocetWithParms(
      String path, Map<String, dynamic> parms) async {
    return _dio.post(_baseurl + path, queryParameters: parms);
  }

  ///  get 请求
  static Future<Response> getNetSocetWithParms(
      String path, Map<String, dynamic> parms) async {
    return _dio.get(_baseurl + path, queryParameters: parms);
  }

  /// 登录接口
  static Future<Response> userLoginWithParms(Map<String, String> parms) async {
    return postNetSocetWithParms("/login/cellphone", parms);
  }
}
