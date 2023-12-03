import 'package:flutter/material.dart';
import 'package:overtimertracker_flutter/Components/overtime_card.dart';
import 'package:overtimertracker_flutter/Models/Providers/overtime_provider.dart';
import 'package:overtimertracker_flutter/Models/overtime_data.dart';
import 'package:provider/provider.dart';

class OvertimeList extends StatelessWidget {
  const OvertimeList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (OvertimeData data
            in Provider.of<OvertimeProvider>(context).overtimeDataList)
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
                  padding: EdgeInsets.only(right: 8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.delete, size: 50),
                  ),
                ),
              ),
              onDismissed: (direction) {
                Provider.of<OvertimeProvider>(context, listen: false)
                    .removeOvertime(data);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Overtime deleted"),
                  ),
                );
              },
              child: OvertimeCard(overtimeData: data)),
      ],
    );
  }
}
