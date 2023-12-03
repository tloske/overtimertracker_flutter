import 'package:flutter/material.dart';
import 'package:overtimertracker_flutter/Components/expandable_fab.dart';
import 'package:overtimertracker_flutter/Components/overtime_list.dart';
import 'package:overtimertracker_flutter/Models/Providers/overtime_provider.dart';
import 'package:overtimertracker_flutter/Pages/use_overtime_page.dart';
import 'package:provider/provider.dart';

import 'add_overtime_page.dart';

class OvertimePage extends StatelessWidget {
  const OvertimePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Column(
            children: [
              const Text("Overtime Tracker"),
              Text(
                  "Overtime: ${Provider.of<OvertimeProvider>(context).overtimeSum}")
            ],
          ),
        ),
        floatingActionButton: ExpandableFab(distance: 112.0, children: [
          ActionButton(
            icon: const Icon(Icons.add),
            onPressed: () => {
              showModalBottomSheet(
                context: context,
                builder: (_) => ListenableProvider.value(
                    value:
                        Provider.of<OvertimeProvider>(context, listen: false),
                    child: const AddOvertimePage()),
              ),
            },
          ),
          ActionButton(
            icon: const Icon(Icons.remove),
            onPressed: () => {
              showModalBottomSheet(
                context: context,
                builder: (_) => ListenableProvider.value(
                    value:
                        Provider.of<OvertimeProvider>(context, listen: false),
                    child: const UseOvertimePage()),
              ),
            },
          ),
        ]),
        body: const OvertimeList());
  }
}
