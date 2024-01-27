import 'package:overtimertracker_flutter/Models/Providers/ad_provider.dart';
import 'package:overtimertracker_flutter/Utils/save_manager.dart';

import '../overtime_data.dart';

class OvertimeProvider extends AdProvider {
  OvertimeProvider() : super() {
    loadData();
  }

  List<OvertimeData> overtimeDataList = [
    OvertimeData(
      date: DateTime.now(),
      start: DateTime.now(),
      end: DateTime.now(),
      overtime: 10,
    ),
    OvertimeData(
      date: DateTime.now(),
      overtime: 10,
    )
  ];

  double overtimeSum = 0.0;

  void loadData() async {
    final List<dynamic> data = await SaveManager.loadData("data.json") ?? [];
    overtimeDataList =
        List<OvertimeData>.from(data.map((e) => OvertimeData.fromJson(e)));
    calculateOvertime();
    notifyListeners();
  }

  void addOvertime(OvertimeData data) {
    overtimeDataList.add(data);
    calculateOvertime();
    notifyListeners();
    SaveManager.saveData(overtimeDataList, "data.json");
  }

  void removeOvertime(OvertimeData data) {
    overtimeDataList.remove(data);
    calculateOvertime();
    notifyListeners();
    SaveManager.saveData(overtimeDataList, "data.json");
  }

  void calculateOvertime() {
    overtimeSum = 0.0;
    for (OvertimeData data in overtimeDataList) {
      overtimeSum += data.overtime;
    }
  }
}
