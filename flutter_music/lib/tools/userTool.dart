import 'package:flustars/flustars.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttermusic/model/userModel.dart';

class UserTool {
  static UserModel _userModel;

  ///获取用户信息
  static Future<UserModel> getUserInfo() async {
    if (_userModel != null) return _userModel;
    SharedPreferences spTool = await SharedPreferences.getInstance();
    String jsonStr = spTool.get('USER_INFO_ROOT');
    Map<String, dynamic> model = JsonUtil.getObj(jsonStr, (v) => null);
    if (model != null) {
      _userModel = UserModel.fromJson(model);
    }
    return _userModel;
  }

  static saveUserInfo(Map<String, dynamic> info) async {
    SharedPreferences spTool = await SharedPreferences.getInstance();
    String jsonStr = JsonUtil.encodeObj(info);
    spTool.setString("USER_INFO_ROOT", jsonStr);
  }

  static removeUserInfo() async {
    SharedPreferences spTool = await SharedPreferences.getInstance();
    spTool.remove("USER_INFO_ROOT");
    _userModel = null;
  }
}
