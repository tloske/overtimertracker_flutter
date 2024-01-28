import 'dart:io';

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

    final List<String> keys = data.keys.toList();
    keys.sort((a, b) => int.parse(a).compareTo(int.parse(b)));
    await Future.wait(keys.map((key) async => generateList(key, data[key])));

    notifyListeners();
  }

  generateList(String key, dynamic data) async {
    holidayDataList[key] = List<HolidayData>.from(data.map((e) {
      HolidayData holidayData = HolidayData.fromJson(e);
      if (holidayData.start.year == DateTime.now().year) {
        remainingDaysInYear -= holidayData.days;
      }
      return holidayData;
    }));
  }

  void addHolidayData(HolidayData data) async {
    if (!holidayDataList.containsKey(data.start.year.toString())) {
      List<HolidayData> newList = [data];
      holidayDataList[data.start.year.toString()] = newList;
    } else {
      holidayDataList[data.start.year.toString()]?.add(data);
    }

    if (data.start.year == DateTime.now().year) {
      remainingDaysInYear -= data.days;
    }
    SaveManager.saveData(holidayDataList, 'holidaydata.json');
    notifyListeners();
  }

  void removeHolidayData(HolidayData data) async {
    holidayDataList[data.start.year.toString()]!.remove(data);
    if (holidayDataList[data.start.year.toString()]!.isEmpty) {
      holidayDataList.remove(data.start.year.toString());
    }

    if (data.start.year == DateTime.now().year) {
      remainingDaysInYear += data.days;
    }

    SaveManager.saveData(holidayDataList, 'holidaydata.json');
    notifyListeners();
  }

  List<String> getSortedKeys() {
    final List<String> keys = holidayDataList.keys.toList();
    if (keys.length <= 1) {
      return keys;
    }
    keys.sort((a, b) => int.parse(a).compareTo(int.parse(b)));
    return keys;
  }
}
