import 'package:flutter/material.dart';
import 'package:jobsin/presentation/screens/companies_screen.dart';
import 'package:jobsin/presentation/screens/vacancies_screen.dart';

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
