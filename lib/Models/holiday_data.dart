class HolidayData {
  HolidayData({required this.start, required this.end, required this.days});
  final DateTime start;
  final DateTime end;
  final int days;

  HolidayData.fromJson(Map<String, dynamic> json)
      : start = DateTime.parse(json['start']),
        end = DateTime.parse(json['end']),
        days = int.parse(json['days']);

  Map<String, dynamic> toJson() => {
        'start': start.toIso8601String(),
        'end': end.toIso8601String(),
        'days': days.toString(),
      };
}
