import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overtimertracker_flutter/Models/Providers/overtime_provider.dart';
import 'package:overtimertracker_flutter/Models/overtime_data.dart';
import 'package:provider/provider.dart';

import '../Utils/globals.dart';

class AddOvertimePage extends StatefulWidget {
  const AddOvertimePage({super.key});

  @override
  State<AddOvertimePage> createState() => _AddOvertimePageState();
}

class _AddOvertimePageState extends State<AddOvertimePage> {
  DateTime date = DateTime.now();
  DateTime start = DateTime.now();
  DateTime end = DateTime.now();
  double overtime = 0;
  double multiplier = 1;

  final TextEditingController multiplierTextController =
      TextEditingController();

  @override
  void dispose() {
    multiplierTextController.dispose();
    super.dispose();
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("Date"),
              TextButton(
                onPressed: () {
                  _showDialog(
                    CupertinoDatePicker(
                        backgroundColor: Colors.white,
                        minimumYear: DateTime.now().year - 5,
                        maximumYear: DateTime.now().year + 5,
                        initialDateTime: date,
                        mode: CupertinoDatePickerMode.date,
                        showDayOfWeek: true,
                        use24hFormat: true,
                        onDateTimeChanged: (DateTime newDate) {
                          setState(() {
                            date = newDate;
                          });
                        }),
                  );
                },
                child: Text(dateFormat.format(date)),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("Start"),
              TextButton(
                onPressed: () {
                  _showDialog(
                    CupertinoDatePicker(
                      backgroundColor: Colors.white,
                      initialDateTime: start,
                      mode: CupertinoDatePickerMode.time,
                      use24hFormat: true,
                      onDateTimeChanged: (DateTime newTime) {
                        setState(() {
                          start = newTime;
                          overtime = end.difference(start).inMinutes / 60.0;
                        });
                      },
                    ),
                  );
                },
                child: Text(
                  timeFormat.format(start),
                ),
              )
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
                      initialDateTime: end,
                      mode: CupertinoDatePickerMode.time,
                      use24hFormat: true,
                      onDateTimeChanged: (DateTime newTime) {
                        setState(() {
                          end = newTime;
                          overtime = end.difference(start).inMinutes / 60.0;
                        });
                      },
                    ),
                  );
                },
                child: Text(
                  timeFormat.format(end),
                ),
              )
            ],
          ),
          TextField(
            controller: multiplierTextController,
            textAlign: TextAlign.center,
            onChanged: (value) {
              setState(() {
                multiplier = double.parse(value);
              });
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text(
                "Multiplier",
                style: TextStyle(fontSize: 12),
              ),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'\d+[,.]?\d*'),
              ),
              TextInputFormatter.withFunction(
                (oldValue, newValue) => newValue.copyWith(
                  text: newValue.text.replaceAll(',', '.'),
                ),
              ),
            ],
          ),
          Text(
            "Overtime ${(overtime * multiplier).toStringAsFixed(2)}",
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
          TextButton(
            onPressed: () {
              Provider.of<OvertimeProvider>(context, listen: false).addOvertime(
                OvertimeData(
                  date: date,
                  overtime: overtime * multiplier,
                  start: start,
                  end: end,
                ),
              );
              Navigator.pop(context);
            },
            child: const Text("Save"),
          )
        ],
      ),
    );
  }
}
