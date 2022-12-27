import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobsin/domain/model/enums/companies_sort_element.dart';
import 'package:jobsin/presentation/providers/companies_provider.dart';
import 'package:jobsin/presentation/screens/companies_screen.dart';
import 'package:jobsin/presentation/screens/vacancies_screen.dart';
import 'package:provider/provider.dart';

import '../../domain/model/enums/vacancies_sort_element.dart';
import '../../injector_container.dart';
import '../providers/menu_provider.dart';
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
    MultiProvider(
      providers: [
        ChangeNotifierProvider<MenuProvider<VacanciesSortElement>>(
          create: (context) => MenuProvider<VacanciesSortElement>(
            itemSortField: VacanciesSortElement.none,
          ),
        ),
        ChangeNotifierProxyProvider<MenuProvider<VacanciesSortElement>,
            VacanciesProvider>(
          create: (context) => VacanciesProvider(
            context: context,
            useCaseGetVacanciesList: sl(),
          ),
          update: (context, menu, vacancies) {
            vacancies?.menuUpdate(menu);
            return vacancies!;
          },
        ),
      ],
      child: const VacanciesScreen(),
    ),
    MultiProvider(
      providers: [
        ChangeNotifierProvider<MenuProvider<CompaniesSortElement>>(
          create: (context) => MenuProvider<CompaniesSortElement>(
            itemSortField: CompaniesSortElement.none,
          ),
        ),
        ChangeNotifierProxyProvider<MenuProvider<CompaniesSortElement>,
            CompaniesProvider>(
          create: (context) => CompaniesProvider(useCaseGetCompaniesList: sl()),
          update: (context, menu, companies) {
            companies?.menuUpdate(menu);
            return companies!;
          },
        )
      ],
      child: const CompaniesScreen(),
    ),
  ];

  // ChangeNotifierProvider<CompaniesProvider>(create: (context) => CompaniesProvider(useCaseGetCompaniesList: sl()),),

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
