import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;

import 'package:path_provider/path_provider.dart';

class SaveManager {
  static saveData(dynamic data, String fileName) async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String appDirPath = appDir.path;
    File file = File(p.join(appDirPath, fileName));
    file.writeAsString(jsonEncode(data));
  }

  static Future loadData(String fileName) async {
    final appDir = await getApplicationDocumentsDirectory();
    final appDirPath = appDir.path;
    if (await File(p.join(appDirPath, fileName)).exists()) {
      File file = File(p.join(appDirPath, fileName));
      String data = await file.readAsString();
      return jsonDecode(data) as List<dynamic>;
    }
    return null;
  }
}
