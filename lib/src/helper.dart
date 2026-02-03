import 'package:aprog_dart/src/classes/aprog_wrapper.dart';
import 'package:aprog_dart/src/classes/storage.dart';

/// Перевірка на порожні дані
bool isEmpty(dynamic value)
{
  if (value == null) return true;

  if (value is bool) return value == false;

  if (value is num) return value == 0;

  if (value is String) {
    return value.trim().isEmpty || value == '0';
  }

  if (value is Iterable || value is Map) {
    return value.isEmpty;
  }

  return false;
}

/// Перевірка на `null`
bool isNull(dynamic value)
{
  return value == null;
}

/// Допоміжна обгортка для отримання даних
AprogWrapper wrap(dynamic value) => AprogWrapper(value);
