import 'package:shared_preferences/shared_preferences.dart';

Future<bool> getPrefsBool(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(key) ?? false;
}

Future<String> getPrefsString(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key) ?? '';
}

Future<void> setPrefs(String key, bool value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
}

Future<void> setPrefsString(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

Future<void> removePrefs(String key) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}

Future<void> clearPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

Future<Map<String, dynamic>> getAllPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getKeys().fold<Map<String, dynamic>>(
      {}, (map, key) => map..putIfAbsent(key, () => prefs.get(key)));
}
