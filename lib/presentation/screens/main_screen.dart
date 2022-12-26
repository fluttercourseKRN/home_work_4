import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobsin/presentation/screens/companies_screen.dart';
import 'package:jobsin/presentation/screens/vacancies_screen.dart';
import 'package:provider/provider.dart';

import '../../injector_container.dart';
import '../providers/companies_provider.dart';
import '../providers/vacancies_provider.dart';
import '../widgets/app_bar_main.dart';
import '../widgets/app_drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const route = "/";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentScreen = 0;
  final screens = [
    ChangeNotifierProvider<VacanciesProvider>(
      create: (context) => VacanciesProvider(useCaseGetVacanciesList: sl()),
      child: const VacanciesScreen(),
    ),
    ChangeNotifierProvider<CompaniesProvider>(
      create: (context) => CompaniesProvider(useCaseGetCompaniesList: sl()),
      child: const CompaniesScreen(),
    ),
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
