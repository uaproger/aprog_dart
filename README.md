# 📦 aprog

🇺🇦 **Українська** | 🇬🇧 **English**

---

## 🇺🇦 Опис

`aprog_dart` — це легкий утилітарний пакет для розробників на **Dart** та **Flutter**.

Пакет надає зручні хелпери для:

- кольорового та форматованого виводу в консоль
- красивого (`pretty`) виводу JSON
- debug-хелперів, подібних до `dump()` / `dd()` з PHP
- читабельного логування з інформацією про файл і рядок коду
- безпечного доступу до даних через `AprogWrapper`
- простого локального сховища (`Storage`)

Ідеально підходить для налагодження Flutter-додатків та Dart CLI-інструментів.

---

## 🇬🇧 Description

`aprog_dart` is a lightweight utility package for **Dart** and **Flutter** developers.

It provides convenient helpers for:

- colored and formatted console output
- pretty-printed JSON output
- debug helpers similar to PHP `dump()` / `dd()`
- readable logging with file and line information
- safe data access via `AprogWrapper`
- simple local storage helper (`Storage`)

Ideal for debugging Flutter applications and Dart CLI tools.

---

## 🚀 Можливості / Features

- 🎨 ANSI-кольори / ANSI colored output
- 🧱 Форматований текст / Styled text helpers
- 📦 Pretty JSON з відступами / Pretty JSON with indentation
- 🐞 `dump()` з контекстом файлу та рядка / stack-aware `dump()`
- 💀 `dd()` (dump & exit)
- 🧠 Безпечний вивід великих логів / chunked large logs
- 🧩 `wrap()` / `AprogWrapper` для безпечного доступу до даних
- 💾 `Storage` для локального сховища

---

## 🛠 Початок роботи / Getting started

```bash
dart pub add aprog
```


### 🧩AprogWrapper — приклад / example
```dart
import 'package:aprog/aprog.dart';

final AprogWrapper config = wrap({
  'key': 'value',
  'key2': {
    'key3': 'value',
  },
});

print(config.get('key').val);
print(config.path('key2.key3').val);
```

### 💾 Storage — приклад / example
```dart
import 'package:aprog_dart/aprog_dart.dart';

await storage.set('user', {
  'name': 'Oleksandr',
  'email': 'test@test.com',
});

final user = await storage.get<Map<String, dynamic>>('user');
```

Copyright AlexProger 2026
