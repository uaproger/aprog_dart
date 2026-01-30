// Стандартні (8 штук)
const black   = '\x1B[30m';
const red     = '\x1B[31m';
const green   = '\x1B[32m';
const yellow  = '\x1B[33m';
const blue    = '\x1B[34m';
const purple  = '\x1B[35m'; // magenta
const cyan    = '\x1B[36m';
const white   = '\x1B[37m';

// Яскраві / light (bright)
const brightBlack   = '\x1B[90m'; // dark gray
const brightRed     = '\x1B[91m';
const brightGreen   = '\x1B[92m';
const brightYellow  = '\x1B[93m';
const brightBlue    = '\x1B[94m';
const brightPurple  = '\x1B[95m';
const brightCyan    = '\x1B[96m';
const brightWhite   = '\x1B[97m';

// Backgrounds
// Звичайні
const bgBlack   = '\x1B[40m';
const bgRed     = '\x1B[41m';
const bgGreen   = '\x1B[42m';
const bgYellow  = '\x1B[43m';
const bgBlue    = '\x1B[44m';
const bgPurple  = '\x1B[45m';
const bgCyan    = '\x1B[46m';
const bgWhite   = '\x1B[47m';

// Яскраві
const bgBrightBlack   = '\x1B[100m';
const bgBrightRed     = '\x1B[101m';
const bgBrightGreen   = '\x1B[102m';
const bgBrightYellow  = '\x1B[103m';
const bgBrightBlue    = '\x1B[104m';
const bgBrightPurple  = '\x1B[105m';
const bgBrightCyan    = '\x1B[106m';
const bgBrightWhite   = '\x1B[107m';

// СТИЛІ ТЕКСТУ
const reset      = '\x1B[0m';
const boldText   = '\x1B[1m';
const dim        = '\x1B[2m';
const italic     = '\x1B[3m';   // не всюди підтримується
const underline  = '\x1B[4m';
const blink      = '\x1B[5m';   // майже ніде не працює
const reverse    = '\x1B[7m';   // інверсія
const hidden     = '\x1B[8m';
const strike     = '\x1B[9m';   // закреслення

String bold(String text)
{
  const bold = '\x1B[1m';
  const reset = '\x1B[0m';
  return '$bold$text$reset';
}

String color(String ansiColor, String text)
{
  const reset = '\x1B[0m';
  return '$ansiColor$text$reset';
}

String rgb(int r, int g, int b) => '\x1B[38;2;$r;$g;${b}m';
String bgRgb(int r, int g, int b) => '\x1B[48;2;$r;$g;${b}m';

String colorizeJson(dynamic value, {int indent = 0})
{
  final space = '  ' * indent;

  if (value is Map) {
    final buffer = StringBuffer();
    buffer.writeln('{');

    final entries = value.entries.toList();
    for (var i = 0; i < entries.length; i++) {
      final e = entries[i];
      buffer.write(space);
      buffer.write('  ');
      buffer.write(color(brightBlue, '"${e.key}"'));
      buffer.write(': ');
      buffer.write(colorizeJson(e.value, indent: indent + 1));
      if (i < entries.length - 1) buffer.write(',');
      buffer.writeln();
    }

    buffer.write(space);
    buffer.write('}');
    return buffer.toString();
  }

  if (value is List) {
    final buffer = StringBuffer();
    buffer.writeln('[');

    for (var i = 0; i < value.length; i++) {
      buffer.write(space);
      buffer.write('  ');
      buffer.write(colorizeJson(value[i], indent: indent + 1));
      if (i < value.length - 1) buffer.write(',');
      buffer.writeln();
    }

    buffer.write(space);
    buffer.write(']');
    return buffer.toString();
  }

  if (value is String) {
    return color(green, '"$value"');
  }

  if (value is num) {
    return color(cyan, value.toString());
  }

  if (value is bool || value == null) {
    return color(yellow, value.toString());
  }

  return value.toString();
}
