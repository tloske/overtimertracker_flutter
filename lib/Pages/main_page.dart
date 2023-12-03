import 'package:flutter/material.dart';
import 'package:overtimertracker_flutter/Pages/overtime_page.dart';
import 'package:provider/provider.dart';

import '../Components/overtime_list.dart';
import '../Models/Providers/overtime_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  List<Widget> routes = [
    ChangeNotifierProvider(
      create: (context) => OvertimeProvider(),
      child: const OvertimePage(),
    ),
    ChangeNotifierProvider(
      create: (context) => OvertimeProvider(),
      child: const OvertimePage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: routes[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => {setState(() => _selectedIndex = index)},
          currentIndex: _selectedIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.punch_clock),
              label: "Overtime",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.punch_clock),
              label: "Overtime",
            ),
          ],
        ),
      ),
    );
  }
}
