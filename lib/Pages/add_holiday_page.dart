import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overtimertracker_flutter/Models/Providers/holiday_provider.dart';
import 'package:overtimertracker_flutter/Models/holiday_data.dart';
import 'package:overtimertracker_flutter/Utils/globals.dart';
import 'package:provider/provider.dart';

class AddHolidayPage extends StatefulWidget {
  const AddHolidayPage({super.key});

  @override
  State<AddHolidayPage> createState() => _AddHolidayPageState();
}

class _AddHolidayPageState extends State<AddHolidayPage> {
  DateTime start = DateTime.now();
  DateTime end = DateTime.now();
  int days = 0;

  final TextEditingController daysTextController = TextEditingController();

  @override
  void dispose() {
    daysTextController.dispose();
    super.dispose();
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  int _calculateHolidays(DateTime start, DateTime end) {
    start = start.copyWith(
        hour: 0, minute: 0, second: 0, microsecond: 0, millisecond: 0);
    end = end.copyWith(
        hour: 0, minute: 0, second: 0, microsecond: 0, millisecond: 0);
    int days = 0;
    while (start.isBefore(end) || start.isAtSameMomentAs(end)) {
      if (start.weekday != DateTime.saturday &&
          start.weekday != DateTime.sunday) {
        days++;
      }
      start = start.add(const Duration(days: 1));
    }
    return days;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          10, 10, 10, MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("Start"),
              TextButton(
                onPressed: () {
                  _showDialog(
                    CupertinoDatePicker(
                      backgroundColor: Colors.white,
                      minimumYear: DateTime.now().year - 5,
                      maximumYear: DateTime.now().year + 5,
                      initialDateTime: start,
                      mode: CupertinoDatePickerMode.date,
                      showDayOfWeek: true,
                      use24hFormat: true,
                      onDateTimeChanged: (DateTime newDate) {
                        setState(() {
                          start = newDate;
                          days = _calculateHolidays(start, end);
                          daysTextController.text = days.toString();
                        });
                      },
                    ),
                  );
                },
                child: Text(dateFormat.format(start)),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("End"),
              TextButton(
                onPressed: () {
                  _showDialog(
                    CupertinoDatePicker(
                      backgroundColor: Colors.white,
                      minimumYear: DateTime.now().year - 5,
                      maximumYear: DateTime.now().year + 5,
                      initialDateTime: end,
                      mode: CupertinoDatePickerMode.date,
                      showDayOfWeek: true,
                      use24hFormat: true,
                      onDateTimeChanged: (DateTime newDate) {
                        setState(() {
                          end = newDate;
                          days = _calculateHolidays(start, end);
                          daysTextController.text = days.toString();
                        });
                      },
                    ),
                  );
                },
                child: Text(dateFormat.format(end)),
              ),
            ],
          ),
          TextField(
            controller: daysTextController,
            textAlign: TextAlign.center,
            onChanged: (value) {
              setState(() {
                days = int.parse(value);
              });
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text(
                "Days",
                style: TextStyle(fontSize: 12),
              ),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: false),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'\d+'),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              Provider.of<HolidayProvider>(context, listen: false)
                  .addHolidayData(HolidayData(
                start: start,
                end: end,
                days: days,
              ));
              Navigator.pop(context);
            },
            child: const Text(
              "Save",
              style: TextStyle(fontSize: 24.0),
            ),
          ),
        ],
      ),
    );
  }
}
