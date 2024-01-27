import 'package:flutter/material.dart';
import 'package:overtimertracker_flutter/Models/Providers/holiday_provider.dart';
import 'package:overtimertracker_flutter/Utils/globals.dart';
import 'package:provider/provider.dart';

import '../Models/holiday_data.dart';

class ExpandableList extends StatefulWidget {
  const ExpandableList({super.key, required this.data, required this.year});

  final List<HolidayData> data;
  final String year;

  @override
  State<ExpandableList> createState() => _ExpandableListState();
}

class _ExpandableListState extends State<ExpandableList> {
  bool bShowList = false;

  int _calculateDays() {
    int days = 0;
    for (HolidayData holiday in widget.data) {
      days += holiday.days;
    }
    return days;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedTextColor: Theme.of(context).colorScheme.onSecondary,
      collapsedShape: Border(
        bottom: BorderSide(
          strokeAlign: BorderSide.strokeAlignInside,
          color: Theme.of(context).colorScheme.onSecondaryContainer,
          width: 2,
        ),
      ),
      collapsedBackgroundColor: Theme.of(context).colorScheme.secondary,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      textColor: Theme.of(context).colorScheme.onSecondary,
      shape: Border(
        bottom: BorderSide(
          strokeAlign: BorderSide.strokeAlignInside,
          color: Theme.of(context).colorScheme.onSecondaryContainer,
          width: 2,
        ),
      ),
      title: Text(widget.year),
      trailing: Text("Days: ${_calculateDays()}"),
      children: [
        for (HolidayData holiday in widget.data)
          Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            background: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.rectangle,
                border: Border.all(
                  width: 2.0,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.only(
                  right: 8.0,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.delete,
                    size: 50,
                  ),
                ),
              ),
            ),
            onDismissed: (direction) {
              Provider.of<HolidayProvider>(context, listen: false)
                  .removeHolidayData(holiday);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                textColor: Theme.of(context).colorScheme.onSecondary,
                title: Text(
                    "${dateFormat.format(holiday.start)} - ${dateFormat.format(holiday.end)}"),
                trailing: Text("Days: ${holiday.days}"),
              ),
            ),
          ),
      ],
    );
  }
}
