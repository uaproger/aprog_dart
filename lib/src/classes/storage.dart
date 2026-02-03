import 'dart:convert';
import 'package:aprog_dart/aprog_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  /// --- Отримати елемент зі сховища ---
  static Future<T?> get<T>(String key, [T? defaulting]) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(key);

      if (raw == null || raw.isEmpty) {
        return defaulting;
      }

      return jsonDecode(raw) as T;
    } catch (e) {
      // ignore: avoid_print
      terminal({
        'error': true,
        'message': 'storage.get: invalid JSON for key "$key": $e',
      });
      return defaulting;
    }
  }

  /// --- Додати елемент у сховище ---
  static Future<void> set(String key, dynamic data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(data));
  }

  /// --- Перевірка на існування елемента ---
  static Future<bool> check(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  /// --- Видалити елемент зі сховища ---
  static Future<void> delete(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
