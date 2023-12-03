class OvertimeData {
  OvertimeData({
    required this.date,
    required this.overtime,
    this.start,
    this.end,
  });
  final DateTime date;
  final DateTime? start;
  final DateTime? end;
  final double overtime;

  OvertimeData.fromJson(Map<String, dynamic> json)
      : date = DateTime.parse(json['date']),
        start = DateTime.tryParse(json['start']),
        end = DateTime.tryParse(json['end']),
        overtime = double.parse(json['overtime']);

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'start': start.toString(),
        'end': end.toString(),
        'overtime': overtime.toString(),
      };
}
