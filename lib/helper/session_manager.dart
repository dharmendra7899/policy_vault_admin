
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class SessionManager {
  Future<void> setToken(String token);

  Future<String> getToken();

  Future<dynamic> getSession();

  Future<void> setSession(dynamic userData);

  Future<void> clearSession();
}

class SessionManagerImp implements SessionManager {
  final SharedPreferences sharedPreferences;
  SessionManagerImp({required this.sharedPreferences});

  @override
  Future<dynamic> getSession() async {
    var data = sharedPreferences.getString(Keys.USERDETAILS.toString());
    if (data != null) {
      return null;
    }
    return dynamic;
  }

  @override
  Future<void> setSession(dynamic userData) async {
    await sharedPreferences.setString(
        Keys.USERDETAILS.toString(), "jsonEncode(userData.toJson())");
  }

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
