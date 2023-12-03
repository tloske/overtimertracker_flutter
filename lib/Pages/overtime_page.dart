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
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          shape: Border(
            bottom: BorderSide(
              strokeAlign: BorderSide.strokeAlignInside,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              width: 2,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                const Text("Overtime Tracker"),
                Text(
                  "Overtime: ${Provider.of<OvertimeProvider>(context).overtimeSum}",
                  style: const TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: ExpandableFab(distance: 112.0, children: [
          ActionButton(
            icon: const Icon(Icons.add),
            onPressed: () => {
              showModalBottomSheet(
                isScrollControlled: true,
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
                isScrollControlled: true,
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
