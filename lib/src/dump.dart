import 'dart:io';
import 'dart:convert';
import 'color.dart';
import 'package:flutter/foundation.dart';

/// Перевірка на формат JSON
String prettyJson(dynamic data)
{
  try {
    dynamic decoded = data;

    if (data is String) {
      decoded = jsonDecode(data);
    }

    if (decoded is Map || decoded is List) {
      return colorizeJson(decoded);
    }
  } catch (_) {}

  return data.toString();
}

/// Друк частинами
void printInChunks(String text, {int chunkSize = 800})
{
  for (var i = 0; i < text.length; i += chunkSize) {
    final end = (i + chunkSize < text.length)
      ? i + chunkSize
      : text.length;
    print(text.substring(i, end));
  }
}

/// Друк даних у консоль
void dump(dynamic data, [int depth = 1, bool path = false])
{
  String two(int n) => n.toString().padLeft(2, '0');

  final now = DateTime.now();
  final date = bold(
    color(
      brightPurple,
      '${now.year}-${two(now.month)}-${two(now.day)} '
          '${two(now.hour)}:${two(now.minute)}:${two(now.second)}',
    ),
  );

  final stack = StackTrace.current.toString().split('\n');
  final line = stack.length > depth ? stack[depth] : '';

  final fileMatch = RegExp(r'\((.*):(\d+):\d+\)').firstMatch(line);
  final funcMatch = RegExp(r'#\d+\s+(.+?)\s+\(').firstMatch(line);

  final file = fileMatch?.group(1) ?? 'unknown';
  final lineNum = fileMatch?.group(2) ?? '0';
  final func = funcMatch?.group(1) ?? 'unknown';

  final header = path
      ? bold(color(brightBlue, '$file:$lineNum'))
      : bold(color(brightGreen, '$func:$lineNum'));

  final body = prettyJson(data);

  print('\n[$date] — $header');
  printInChunks(body);
  print(bold(color(brightPurple, '[$date] — Close block')));
  print(''); // порожній рядок для читабельності
}

/// Друк даних у консоль, та зупинка виконання коду
void dd(dynamic data, {int code = 1, int depth = 1, bool path = false})
{
  String two(int n) => n.toString().padLeft(2, '0');

  final now = DateTime.now();
  final date = bold(
    color(
      brightPurple,
      '${now.year}-${two(now.month)}-${two(now.day)} '
          '${two(now.hour)}:${two(now.minute)}:${two(now.second)}',
    ),
  );

  final stack = StackTrace.current.toString().split('\n');
  final line = stack.length > depth ? stack[depth] : '';

  final fileMatch = RegExp(r'\((.*):(\d+):\d+\)').firstMatch(line);
  final funcMatch = RegExp(r'#\d+\s+(.+?)\s+\(').firstMatch(line);

  final file = fileMatch?.group(1) ?? 'unknown';
  final lineNum = fileMatch?.group(2) ?? '0';
  final func = funcMatch?.group(1) ?? 'unknown';

  final header = path
      ? bold(color(brightBlue, '$file:$lineNum'))
      : bold(color(brightGreen, '$func:$lineNum'));

  final body = prettyJson(data);

  print('\n[$date] — $header');
  printInChunks(body);
  print(bold(color(brightPurple, '[$date] — Close block')));
  print(''); // порожній рядок для читабельності
  exit(code);
}

void terminal(dynamic data)
{
  debugPrint(const JsonEncoder.withIndent('  ').convert(data));
}
