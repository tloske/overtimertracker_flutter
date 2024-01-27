import 'package:overtimertracker_flutter/Models/Providers/ad_provider.dart';
import 'package:overtimertracker_flutter/Utils/save_manager.dart';

import '../holiday_data.dart';

class HolidayProvider extends AdProvider {
  HolidayProvider() : super() {
    loadData();
  }

  int remainingDaysInYear = 27;

  Map<String, List<HolidayData>> holidayDataList = {};

  void loadData() async {
    final Map<String, dynamic> data =
        await SaveManager.loadData("holidaydata.json") ?? {};
    for (String key in data.keys) {
      holidayDataList[key] =
          List<HolidayData>.from(data[key].map((e) => HolidayData.fromJson(e)));
    }

    notifyListeners();
  }

  void addHolidayData(HolidayData data) async {
    if (!holidayDataList.containsKey(data.start.year.toString())) {
      List<HolidayData> newList = [data];
      holidayDataList[data.start.year.toString()] = newList;
    } else {
      holidayDataList[data.start.year.toString()]?.add(data);
    }
    SaveManager.saveData(holidayDataList, 'holidaydata.json');
    notifyListeners();
  }

  void removeHolidayData(HolidayData data) async {
    holidayDataList[data.start.year.toString()]!.remove(data);
    if (holidayDataList[data.start.year.toString()]!.isEmpty) {
      holidayDataList.remove(data.start.year.toString());
    }

    SaveManager.saveData(holidayDataList, 'holidaydata.json');
    notifyListeners();
  }
}
