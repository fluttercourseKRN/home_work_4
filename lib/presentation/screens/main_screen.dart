import 'package:flutter/material.dart';
import 'package:jobsin/presentation/widgets/companies_list.dart';

import 'vacancies_screen/widgets/vacancies_list.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const route = "/";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentScreen = 0;
  final screens = [
    const VacanciesList(),
    const CompaniesList(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentScreen,
        onTap: (value) => setState(() => currentScreen = value),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.place),
            label: 'Vacancies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.plagiarism),
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
