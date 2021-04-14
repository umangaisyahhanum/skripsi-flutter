import 'package:shared_preferences/shared_preferences.dart';

class SharedValue {
  static SharedPreferences prefs;

  static Future<void> intit() async {
    prefs = await SharedPreferences.getInstance();
  }

  static String getUserId() {
    return prefs.getString('user_id');
  }

  static setUserId(String userId) async {
    prefs.setString('user_id', userId);
  }

  static String getUserEmail() {
    return prefs.getString('user_email');
  }

  static setUserEmail(String userId) async {
    prefs.setString('user_email', userId);
  }

  static logout() {
    prefs.remove('user_id');
    prefs.remove('user_email');
  }
}
