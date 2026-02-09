import 'package:aprog/src/classes/aprog_wrapper.dart';

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

/// Функція `date()` за прикладом як у PHP
String date(String format, [DateTime? dateTime]) {
  final date = dateTime ?? DateTime.now();

  Map<String, String> formatMap = {
    'Y': date.year.toString(),
    'm': date.month.toString().padLeft(2, '0'),
    'd': date.day.toString().padLeft(2, '0'),
    'H': date.hour.toString().padLeft(2, '0'),
    'i': date.minute.toString().padLeft(2, '0'),
    's': date.second.toString().padLeft(2, '0'),
    'y': date.year.toString().substring(2),
    'j': date.day.toString(),
    'n': date.month.toString(),
  };

  String result = format;
  formatMap.forEach((key, value) {
    result = result.replaceAll(key, value);
  });

  return result;
}
