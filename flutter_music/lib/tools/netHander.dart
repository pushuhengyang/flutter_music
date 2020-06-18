///网络库
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttermusic/application.dart';
import 'package:fluttermusic/model/bannermodel.dart';
import 'package:fluttermusic/model/songsheetModel.dart';
import 'package:fluttermusic/widgets/hub.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

typedef ComplentCallBack = Function(Map<String, dynamic> data, DioError error);

class NetHander {
  static Dio _dio;

  static void standIndex() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    CookieJar cj = PersistCookieJar(dir: tempPath);
    _dio = Dio(BaseOptions(baseUrl: "http://localhost:3000"))
      ..interceptors.add(CookieManager(cj))
      ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

  ///post 请求
  static postNetSocetWithParms(String path, Map<String, dynamic> parms,
      {ComplentCallBack complent}) async {
    _dio.post(path, queryParameters: parms).then(
        (value) => {
              if (complent != null) {complent(value.data, null)}
            }, onError: (error) {
      if (complent != null) {
        complent(null, error);
      }
    });
  }

  ///  get 请求
  static getNetSocetWithParms(String path, Map<String, dynamic> parms,
      {ComplentCallBack complent}) async {
    _dio.post(path, queryParameters: parms).then(
        (value) => {
              if (complent != null) {complent(value.data, null)}
            }, onError: (error) {
      if (complent != null) {
        complent(null, error);
      }
    });
  }

  _relogin() {
    Future.delayed(Duration(milliseconds: 200), () {
//      AppLication.getIt<NavigateService>().popAndPushNamed(Routes.login);
//      Utils.showToast('登录失效，请重新登录');
    });
  }

  static Future<Response> _get(
    String url, {
    Map<String, dynamic> params,
    BuildContext context,
    bool isShowLoading = true,
  }) async {
    if (isShowLoading && context != null) Loading.showLoading(context);
    try {
      return await _dio.get(url, queryParameters: params);
    } on DioError catch (e) {
      if (e == null) {
        return Future.error(Response(data: -1));
      } else if (e.response != null) {
        if (e.response.statusCode >= 300 && e.response.statusCode < 400) {
//          _reLogin();
          // 这里做登录处理
          return Future.error(Response(data: -1));
        } else {
          return Future.value(e.response);
        }
      } else {
        return Future.error(Response(data: -1));
      }
    } finally {
      if (context != null) Loading.hideLoading(context);
    }
  }

  static Future<Response> _post(
    String url, {
    Map<String, dynamic> params,
    BuildContext context,
    bool isShowLoading = true,
  }) async {
    if (isShowLoading && context != null) Loading.showLoading(context);

    try {
      return await _dio.post(url, queryParameters: params);
    } on DioError catch (e) {
      if (e == null) {
        return Future.error(Response(data: -1));
      } else if (e.response != null) {
        if (e.response.statusCode >= 300 && e.response.statusCode < 400) {
//          _reLogin();
          // 这里做登录处理
          return Future.error(Response(data: -1));
        } else {
          return Future.value(e.response);
        }
      } else {
        return Future.error(Response(data: -1));
      }
    } finally {
      if (context != null) Loading.hideLoading(context);
    }
  }

  /// 登录接口
  static Future<Response> userLoginWithParms(
      Map<String, String> parms, BuildContext context) async {
    return _post(
      "/login/cellphone",
      params: parms,
      context: context,
      isShowLoading: true,
    );
  }

  /// banner  图
  static Future<BannerModel> getBannerData(BuildContext context) async {
    var response = await _get('/banner', params: {'type': 2}, context: context);
    return BannerModel.fromJson(response.data);
  }

  /// 热门歌单
  static Future<SongSheetModel> getHotSongSheetData(
    BuildContext context, {
    String limit = "20",
  }) async {
    var res = await _get("/top/playlist", params: {"limit": limit});
    return SongSheetModel.fromJson(res.data);
  }
}
