import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:overtimertracker_flutter/Components/holiday_list.dart';
import 'package:overtimertracker_flutter/Models/Providers/holiday_provider.dart';
import 'package:overtimertracker_flutter/Models/holiday_data.dart';
import 'package:overtimertracker_flutter/Pages/add_holiday_page.dart';
import 'package:provider/provider.dart';

class HolidayPage extends StatelessWidget {
  const HolidayPage({super.key});

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
        title: const Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            children: [
              Text("Holidays"),
              Text(
                "Remaining this year: 24",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const HolidayList(),
          if (Provider.of<HolidayProvider>(context).bShowAd &&
              Provider.of<HolidayProvider>(context).bannerAd != null)
            Align(
              alignment: Alignment.bottomLeft,
              child: SafeArea(
                child: SizedBox(
                  width: Provider.of<HolidayProvider>(context)
                      .bannerAd!
                      .size
                      .width
                      .toDouble(),
                  height: Provider.of<HolidayProvider>(context)
                      .bannerAd!
                      .size
                      .height
                      .toDouble(),
                  child: AdWidget(
                    ad: Provider.of<HolidayProvider>(context).bannerAd!,
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (_) => ListenableProvider.value(
              value: Provider.of<HolidayProvider>(context, listen: false),
              child: const AddHolidayPage(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
