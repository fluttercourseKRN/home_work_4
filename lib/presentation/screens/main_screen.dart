import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobsin/presentation/screens/vacancies_screen.dart';

import '../widgets/app_bar_main.dart';
import '../widgets/app_drawer.dart';
import 'companies_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const route = "/";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentScreen = 0;
  final screens = [
    const VacanciesScreen(),
    const CompaniesScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: const AppBarMain(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentScreen,
        onTap: (value) => setState(() => currentScreen = value),
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.fileSignature),
            label: 'Vacancies',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.building),
            label: 'Companies',
          ),
        ],
      ),
      body: SafeArea(
        child: screens[currentScreen],
      ),
    );
  }
}
