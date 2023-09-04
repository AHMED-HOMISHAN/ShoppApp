// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPrefrences;

  static init() async {
    sharedPrefrences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData(
      {required String key, required dynamic value}) async {
    if (value is String) return await sharedPrefrences.setString(key, value);
    if (value is int) return await sharedPrefrences.setInt(key, value);
    if (value is bool) return await sharedPrefrences.setBool(key, value);
    return await sharedPrefrences.setDouble(key, value);
  }

  static dynamic getData({required String key}) {
    return sharedPrefrences.get(key);
  }

  static Future<bool> clearData({required String key}) async {
    return await sharedPrefrences.remove(key);
  }
}
