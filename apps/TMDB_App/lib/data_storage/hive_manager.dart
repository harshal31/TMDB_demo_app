import "package:flutter/foundation.dart";
import "package:hive/hive.dart";
import "package:path_provider/path_provider.dart";

class HiveManager {
  static final HiveManager _instance = HiveManager._internal();
  String? boxName;

  HiveManager._internal() {}

  factory HiveManager.createHiveManager() {
    return _instance;
  }

  Future<void> initialize(String boxName) async {
    this.boxName = boxName;
    if (!kIsWeb) {
      final directory = await getApplicationDocumentsDirectory();
      Hive.init(directory.absolute.path);
    }

    _openBox(boxName);
  }

  Future<void> _openBox(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox(boxName);
    }
  }

  Future<void> putString(String key, String? value) async {
    if (boxName?.isEmpty ?? true) {
      return;
    }

    final Box<dynamic> box = Hive.box(boxName!);
    await box.put(key, value ?? "");
  }

  Future<void> putBool(String key, bool? value) async {
    if (boxName?.isEmpty ?? true) {
      return;
    }
    final Box<dynamic> box = Hive.box(boxName!);
    await box.put(key, value ?? false);
  }

  Future<void> putInt(String key, int? value) async {
    if (boxName?.isEmpty ?? true) {
      return;
    }
    final Box<dynamic> box = Hive.box(boxName!);
    await box.put(key, value ?? 0);
  }

  Future<void> putDouble(String key, double? value) async {
    if (boxName?.isEmpty ?? true) {
      return;
    }
    final Box<dynamic> box = Hive.box(boxName!);
    await box.put(key, value ?? 0.0);
  }

  Future<String> getString(String key) async {
    if (boxName?.isEmpty ?? true) {
      return "";
    }
    final Box<dynamic> box = Hive.box(boxName!);
    dynamic value = await box.get(key, defaultValue: "");
    return value is String ? value : "";
  }

  Future<bool> getBool(String key) async {
    if (boxName?.isEmpty ?? true) {
      return false;
    }
    final Box<dynamic> box = Hive.box(boxName!);
    dynamic value = await box.get(key, defaultValue: false);
    return value is bool ? value : false;
  }

  Future<int> getInt(String key) async {
    if (boxName?.isEmpty ?? true) {
      return 0;
    }
    final Box<dynamic> box = Hive.box(boxName!);
    dynamic value = await box.get(key, defaultValue: false);
    return value is int ? value : 0;
  }

  Future<double> getDouble(String key) async {
    if (boxName?.isEmpty ?? true) {
      return 0.0;
    }
    final Box<dynamic> box = Hive.box(boxName!);
    dynamic value = await box.get(key, defaultValue: false);
    return value is double ? value : 0.0;
  }

  Future<int> clearBox() async {
    final Box<dynamic> box = Hive.box(boxName!);
    int value = await box.clear();
    return value;
  }
}
