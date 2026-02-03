class AprogWrapper {
  final dynamic _value;

  const AprogWrapper(this._value);

  /// ---------- GET ----------

  AprogWrapper key(dynamic key, [dynamic def]) {
    if (_value == null) return AprogWrapper(def);

    if (_value is List) {
      if (key is int && key >= 0 && key < _value.length) {
        return AprogWrapper(_value[key] ?? def);
      }
    }

    if (_value is Map) {
      if (_value.containsKey(key)) {
        final val = _value[key];
        return AprogWrapper(val ?? def);
      }
    }

    return AprogWrapper(def);
  }

  dynamic get(dynamic key, [dynamic def]) {
    return this.key(key, def)._value;
  }

  /// ---------- PATH ----------

  AprogWrapper _path(String path, [dynamic def]) {
    final keys = path.split('.');
    AprogWrapper current = this;

    for (final key in keys) {
      current = current.get(key);
    }

    return current.isNull ? AprogWrapper(def) : current;
  }

  dynamic path(String path, [dynamic def]) {
    return _path(path, def)._value;
  }

  /// ---------- CHECK ----------

  bool has(dynamic key) {
    if (_value == null) return false;
    if (_value is List && key is int) return key >= 0 && key < _value.length;
    if (_value is Map) return _value.containsKey(key);
    return false;
  }

  bool get isNull => _value == null;

  /// ---------- MUTATE (IMMUTABLE) ----------

  AprogWrapper only(List<dynamic> keys) {
    if (_value is! Map) return const AprogWrapper({});

    final result = <dynamic, dynamic>{};
    for (final key in keys) {
      if (_value.containsKey(key)) {
        result[key] = _value[key];
      }
    }

    return AprogWrapper(result);
  }

  /// ---------- CAST ----------

  dynamic get val => _value;

  List get toList {
    if (_value is List) return _value;
    if (_value is Map) return _value.values.toList();
    return [];
  }

  Map get toMap {
    if (_value is Map) return _value;
    return {};
  }
}
