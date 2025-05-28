import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  static const String _boxName = "transaction";
  static late Box hiveBox;
  static initLocalStorage({String? userId}) async {
    await Hive.initFlutter();
    hiveBox = await Hive.openBox("${userId ?? "123"}.$_boxName");
  }

  static Future save(String key, dynamic value) async {
    await hiveBox.put(key, value);
  }

  static dynamic read(String key) {
    return hiveBox.get(key);
  }

  static List<dynamic> readAll() {
    return hiveBox.values.toList();
  }
}
