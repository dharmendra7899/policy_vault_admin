
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class SessionManager {
  Future<void> setToken(String token);

  Future<String> getToken();
  //
  // Future<UserDataModel> getSession();
  //
  // Future<void> setSession(UserDataModel userData);

  Future<void> clearSession();
}

class SessionManagerImp implements SessionManager {
  final SharedPreferences sharedPreferences;
  SessionManagerImp({required this.sharedPreferences});

  // @override
  // Future<UserDataModel> getSession() async {
  //   var data = sharedPreferences.getString(Keys.USERDETAILS.toString());
  //   if (data != null) {
  //     return UserDataModel.fromJson(jsonDecode(data));
  //   }
  //   return UserDataModel();
  // }
  //
  // @override
  // Future<void> setSession(UserDataModel userData) async {
  //   await sharedPreferences.setString(
  //       Keys.USERDETAILS.toString(), jsonEncode(userData.toJson()));
  // }

  @override
  Future<String> getToken() async {
    return sharedPreferences.getString(Keys.TOKEN.toString()) ?? '';
  }

  @override
  Future<void> setToken(String token) async {
    sharedPreferences.setString(Keys.TOKEN.toString(), token);
  }

  @override
  Future<void> clearSession() async {
    sharedPreferences.remove(Keys.TOKEN.toString());
    sharedPreferences.remove(Keys.USERDETAILS.toString());
  }
}

enum Keys { USERDETAILS, WALKTHROUGH, TOKEN }
