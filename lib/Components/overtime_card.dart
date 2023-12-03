import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:overtimertracker_flutter/Models/overtime_data.dart';

import '../Utils/globals.dart';

class OvertimeCard extends StatelessWidget {
  OvertimeCard({super.key, required this.overtimeData});

  final OvertimeData overtimeData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Theme.of(context).colorScheme.secondary,
      textColor: Theme.of(context).colorScheme.onSecondary,
      shape: Border(
        bottom: BorderSide(
          strokeAlign: BorderSide.strokeAlignInside,
          color: Theme.of(context).colorScheme.onSecondaryContainer,
          width: 2,
        ),
      ),
      title: Text(
        dateFormat.format(overtimeData.date),
      ),
      subtitle: overtimeData.start == null || overtimeData.end == null
          ? null
          : Text(
              "${timeFormat.format(overtimeData.start!)} - ${timeFormat.format(overtimeData.end!)}"),
      trailing: Text(
          "${overtimeData.overtime.toStringAsFixed(2)} ${overtimeData.overtime == 1 ? 'hour' : 'hours'}"),
    );
  }
}
