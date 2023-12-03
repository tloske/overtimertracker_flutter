import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overtimertracker_flutter/Models/Providers/overtime_provider.dart';
import 'package:overtimertracker_flutter/Models/overtime_data.dart';
import 'package:overtimertracker_flutter/Utils/globals.dart';
import 'package:provider/provider.dart';

class UseOvertimePage extends StatefulWidget {
  const UseOvertimePage({super.key});

  @override
  State<UseOvertimePage> createState() => _UseOvertimePageState();
}

class _UseOvertimePageState extends State<UseOvertimePage> {
  DateTime date = DateTime.now();

  final TextEditingController overtimeTextController = TextEditingController();
  double overtime = 0;

  @override
  void dispose() {
    overtimeTextController.dispose();
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
        mainAxisSize: MainAxisSize.min,
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
          TextField(
            onChanged: (value) {
              overtime = -double.parse(value);
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text(
                "Hours",
                style: TextStyle(fontSize: 12),
              ),
            ),
            textAlign: TextAlign.center,
            controller: overtimeTextController,
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
          SizedBox(
            width: 200,
            height: 50,
            child: TextButton(
              onPressed: () {
                Provider.of<OvertimeProvider>(context, listen: false)
                    .addOvertime(
                  OvertimeData(
                    date: date,
                    overtime: overtime,
                  ),
                );

                Navigator.pop(context);
              },
              child: const Text(
                "Save",
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
