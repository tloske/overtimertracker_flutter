import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:overtimertracker_flutter/Components/expandable_fab.dart';
import 'package:overtimertracker_flutter/Components/overtime_list.dart';
import 'package:overtimertracker_flutter/Models/Providers/overtime_provider.dart';
import 'package:overtimertracker_flutter/Pages/use_overtime_page.dart';
import 'package:provider/provider.dart';

import 'add_overtime_page.dart';

class OvertimePage extends StatefulWidget {
  const OvertimePage({super.key});

  @override
  State<OvertimePage> createState() => _OvertimePageState();
}

class _OvertimePageState extends State<OvertimePage> {
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
                "Overtime: ${Provider.of<OvertimeProvider>(context).overtimeSum.toStringAsFixed(2)} ${Provider.of<OvertimeProvider>(context).overtimeSum == 1 ? 'hour' : 'hours'}",
                style: const TextStyle(fontSize: 16),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: ExpandableFab(distance: 84.0, children: [
        ActionButton(
          icon: const Icon(Icons.add),
          onPressed: () => {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (_) => ListenableProvider.value(
                  value: Provider.of<OvertimeProvider>(context, listen: false),
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
                  value: Provider.of<OvertimeProvider>(context, listen: false),
                  child: const UseOvertimePage()),
            ),
          },
        ),
      ]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const OvertimeList(),
          if (Provider.of<OvertimeProvider>(context).bShowAd &&
              Provider.of<OvertimeProvider>(context).bannerAd != null)
            Align(
              alignment: Alignment.bottomLeft,
              child: SafeArea(
                child: SizedBox(
                  width: Provider.of<OvertimeProvider>(context)
                      .bannerAd!
                      .size
                      .width
                      .toDouble(),
                  height: Provider.of<OvertimeProvider>(context)
                      .bannerAd!
                      .size
                      .height
                      .toDouble(),
                  child: AdWidget(
                    ad: Provider.of<OvertimeProvider>(context).bannerAd!,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
