import 'dart:convert';
import 'dart:io';

abstract class JsonFileConverter<T> {
  Map<String, dynamic> toJson(T object);
  T fromJson(Map<String, dynamic> json);
}

class JsonFileStorage {
  JsonFileStorage({required this.path});

  final String path;

  JsonFileReference ref(String key) {
    return JsonFileReference._(storage: this, key: key);
  }

  Future<Map<String, dynamic>> _readFile() async {
    final file = File(path);
    if (!await file.exists()) return <String, dynamic>{};
    final data = await file.readAsString();
    return json.decode(data) as Map<String, dynamic>;
  }

  Future<void> _writeFile(Map<String, dynamic> data) async {
    final file = File(path);
    await file.parent.create(recursive: true);
    await file.writeAsString(json.encode(data));
  }

  dynamic _getNestedValue(Map<String, dynamic> data, String path) {
    final keys = path.split('/');
    dynamic current = data;

    for (final key in keys) {
      if (key.isEmpty) continue;
      if (current is Map<String, dynamic> && current.containsKey(key)) {
        current = current[key];
      } else {
        return null;
      }
    }

    return current;
  }

  void _setNestedValue(
    Map<String, dynamic> data,
    String path,
    dynamic value, {
    bool merge = false,
  }) {
    final keys = path.split('/').where((key) => key.isNotEmpty).toList();
    Map<String, dynamic> current = data;

    for (int i = 0; i < keys.length - 1; i++) {
      final key = keys[i];
      if (!current.containsKey(key) || current[key] is! Map<String, dynamic>) {
        current[key] = <String, dynamic>{};
      }
      current = current[key] as Map<String, dynamic>;
    }

    final lastKey = keys.last;
    if (merge &&
        current.containsKey(lastKey) &&
        current[lastKey] is Map<String, dynamic> &&
        value is Map<String, dynamic>) {
      final existingValue = current[lastKey] as Map<String, dynamic>;
      current[lastKey] = {...existingValue, ...value};
    } else {
      current[lastKey] = value;
    }
  }

  void _removeNestedValue(Map<String, dynamic> data, String path) {
    final keys = path.split('/').where((key) => key.isNotEmpty).toList();
    Map<String, dynamic> current = data;

    for (int i = 0; i < keys.length - 1; i++) {
      final key = keys[i];
      if (current.containsKey(key) && current[key] is Map<String, dynamic>) {
        current = current[key] as Map<String, dynamic>;
      } else {
        return; // Path doesn't exist
      }
    }

    current.remove(keys.last);
  }
}

class JsonFileReference<T> {
  JsonFileReference._({
    required this.storage,
    required this.key,
    this.converter,
  });

  final JsonFileStorage storage;
  final String key;
  final JsonFileConverter<T>? converter;

  JsonFileReference<R> withConverter<R>(JsonFileConverter<R> converter) {
    return JsonFileReference<R>._(
      storage: storage,
      key: key,
      converter: converter,
    );
  }

  Future<void> set(T value, {bool merge = false}) async {
    final data = await storage._readFile();
    final jsonValue = converter != null ? converter!.toJson(value) : value;
    storage._setNestedValue(data, key, jsonValue, merge: merge);
    await storage._writeFile(data);
  }

  Future<T?> get() async {
    final data = await storage._readFile();
    final value = storage._getNestedValue(data, key);

    if (value == null) return null;

    if (converter != null && value is Map<String, dynamic>) {
      return converter!.fromJson(value) as T?;
    }

    return value as T?;
  }

  Future<void> delete() async {
    final data = await storage._readFile();
    storage._removeNestedValue(data, key);
    await storage._writeFile(data);
  }

  Future<bool> exists() async {
    final data = await storage._readFile();
    return storage._getNestedValue(data, key) != null;
  }
}
