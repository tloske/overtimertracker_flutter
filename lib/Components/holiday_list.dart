import 'package:flutter/material.dart';
import 'package:overtimertracker_flutter/Components/expandable_list.dart';
import 'package:overtimertracker_flutter/Models/Providers/holiday_provider.dart';
import 'package:provider/provider.dart';

class HolidayList extends StatelessWidget {
  const HolidayList({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView(
        shrinkWrap: true,
        children: [
          for (String key
              in Provider.of<HolidayProvider>(context).getSortedKeys())
            ExpandableList(
                data: Provider.of<HolidayProvider>(context)
                        .holidayDataList[key] ??
                    [],
                year: key),
        ],
      ),
    );
  }
}
