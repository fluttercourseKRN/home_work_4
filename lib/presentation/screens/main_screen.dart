import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobsin/presentation/model/constants.dart';
import 'package:jobsin/presentation/screens/companies_screen.dart';
import 'package:jobsin/presentation/screens/company_edit_screen.dart';
import 'package:jobsin/presentation/screens/vacancies_screen.dart';

import '../model/bottom_navigatio_screen.dart';
import '../widgets/app_bar_main.dart';
import '../widgets/app_drawer.dart';
import 'vacancy_edit_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const route = "/";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentScreen = 0;

  final screens = [
    BottomNavigationScreen(
      icon: FontAwesomeIcons.fileSignature,
      title: 'Vacancies',
      floatingButtonText: 'Add Vacancy',
      onFloatingButtonTap: (context) {
        Navigator.of(context).pushNamed(VacancyEditScreen.route);
      },
      screen: const VacanciesScreen(),
    ),
    BottomNavigationScreen(
      icon: FontAwesomeIcons.building,
      title: 'Companies',
      floatingButtonText: 'Add Company',
      onFloatingButtonTap: (context) {
        Navigator.of(context).pushNamed(CompanyEditScreen.route);
      },
      screen: const CompaniesScreen(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        style: const ButtonStyle(
          elevation: MaterialStatePropertyAll(kAppElevation),
        ),
        onPressed: () => screens[currentScreen].onFloatingButtonTap(context),
        child: Text(screens[currentScreen].floatingButtonText),
      ),
      drawer: const AppDrawer(),
      appBar: const AppBarMain(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentScreen,
        onTap: (value) => setState(() => currentScreen = value),
        items: [
          for (final screen in screens)
            BottomNavigationBarItem(
              icon: FaIcon(screen.icon),
              label: screen.title,
            ),
        ],
      ),
      body: SafeArea(
        child: screens[currentScreen].screen,
      ),
    );
  }
}
