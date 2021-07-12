import 'package:shared_preferences/shared_preferences.dart';

class Pref {
  static Pref _instance;

  Pref._internal();

  factory Pref() {
    if (_instance == null) {
      _instance = Pref._internal();
    }
    return _instance;
  }

  SharedPreferences _sharedPreferences;

  Future<SharedPreferences> _getSharedPreferences() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
    await _sharedPreferences.reload();
    return _sharedPreferences;
  }

  Future<void> putString(String key, String value) async {
    final SharedPreferences sharedPreferences = await _getSharedPreferences();
    sharedPreferences.setString(key, value);
  }

  Future<void> putDouble(String key, double value) async {
    final SharedPreferences sharedPreferences = await _getSharedPreferences();
    sharedPreferences.setDouble(key, value);
  }

  Future<void> putInt(String key, int value) async {
    final SharedPreferences sharedPreferences = await _getSharedPreferences();
    sharedPreferences.setInt(key, value);
  }

  Future<void> putBool(String key, bool value) async {
    final SharedPreferences sharedPreferences = await _getSharedPreferences();
    sharedPreferences.setBool(key, value);
  }

  Future<void> putStringList(String key, List<String> value) async {
    final SharedPreferences sharedPreferences = await _getSharedPreferences();
    sharedPreferences.setStringList(key, value);
  }

  Future<String> getString(String key, {String defaultValue}) async {
    final SharedPreferences sharedPreferences = await _getSharedPreferences();
    return sharedPreferences.getString(key) ?? defaultValue;
  }

  Future<double> getDouble(String key, {double defaultValue}) async {
    final SharedPreferences sharedPreferences = await _getSharedPreferences();
    return sharedPreferences.getDouble(key) ?? defaultValue;
  }

  Future<int> getInt(String key, {int defaultValue}) async {
    final SharedPreferences sharedPreferences = await _getSharedPreferences();
    return sharedPreferences.getInt(key) ?? defaultValue;
  }

  Future<bool> getBool(String key, {bool defaultValue}) async {
    final SharedPreferences sharedPreferences = await _getSharedPreferences();
    return sharedPreferences.getBool(key) ?? defaultValue;
  }

  Future<List<String>> getStringList(String key,
      {List<String> defaultValue}) async {
    final SharedPreferences sharedPreferences = await _getSharedPreferences();
    return sharedPreferences.getStringList(key) ?? defaultValue;
  }

  Future<bool> delete(String key) async {
    final SharedPreferences sharedPreferences = await _getSharedPreferences();
    return sharedPreferences.remove(key);
  }

  Future<Set<String>> getKeys() async {
    final SharedPreferences sharedPreferences = await _getSharedPreferences();
    return sharedPreferences.getKeys();
  }

  Future<bool> clear() async {
    final SharedPreferences sharedPreferences = await _getSharedPreferences();
    return sharedPreferences.clear();
  }
}