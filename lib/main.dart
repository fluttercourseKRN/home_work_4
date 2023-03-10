import 'package:flutter/material.dart';
import 'package:jobsin/presentation/providers/vacancies_provider.dart';
import 'package:provider/provider.dart';

import 'domain/entities/company.dart';
import 'domain/entities/vacancy.dart';
import 'domain/model/enums/companies_sort_element.dart';
import 'domain/model/enums/vacancies_sort_element.dart';
import 'injector_container.dart' as di;
import 'presentation/providers/companies_provider.dart';
import 'presentation/providers/menu_provider.dart';
import 'presentation/screens/company_detail_screen.dart';
import 'presentation/screens/company_edit_screen.dart';
import 'presentation/screens/main_screen.dart';
import 'presentation/screens/vacancy_detail_screen.dart';
import 'presentation/screens/vacancy_edit_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.setUp();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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
            useCaseGetVacanciesList: di.sl(),
            useCaseAddVacancy: di.sl(),
            useCaseEditVacancy: di.sl(),
            useCaseDeleteVacancy: di.sl(),
            useCaseGetMyVacancies: di.sl(),
            useCaseGetMyCompanies: di.sl(),
          ),
          update: (context, menu, vacancies) {
            vacancies?.menuUpdate(menu);
            return vacancies!;
          },
        ),
        ChangeNotifierProvider<MenuProvider<CompaniesSortElement>>(
          create: (context) => MenuProvider<CompaniesSortElement>(
            itemSortField: CompaniesSortElement.none,
          ),
        ),
        ChangeNotifierProxyProvider<MenuProvider<CompaniesSortElement>,
            CompaniesProvider>(
          create: (context) => CompaniesProvider(
            context: context,
            useCaseGetCompaniesList: di.sl(),
            useCaseDeleteCompany: di.sl(),
            useCaseAddCompany: di.sl(),
            useCaseEditCompany: di.sl(),
            useCaseGetMyCompanies: di.sl(),
          ),
          update: (context, menu, companies) {
            companies?.menuUpdate(menu);
            return companies!;
          },
        )
      ],
      child: MaterialApp(
        title: 'JobsIn',
        theme: ThemeData(
          // primarySwatch: Colors.blue,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.teal,
            accentColor: Colors.blueGrey,
          ),
        ),
        initialRoute: MainScreen.route,
        routes: {
          MainScreen.route: (context) => const MainScreen(),
        },
        onGenerateRoute: (settings) {
          switch (settings.name) {

            /// VacancyDetailScreen
            case VacancyDetailScreen.route:
              final vacancy = settings.arguments as Vacancy;
              return MaterialPageRoute(
                builder: (context) => VacancyDetailScreen(vacancy: vacancy),
              );

            /// VacancyEditScreen
            case VacancyEditScreen.route:
              final vacancy = settings.arguments as Vacancy?;
              return MaterialPageRoute(
                builder: (context) =>
                    VacancyEditScreen(initialVacancy: vacancy),
              );

            /// CompanyDetailScreen
            case CompanyDetailScreen.route:
              final company = settings.arguments as Company;
              return MaterialPageRoute(
                builder: (context) => CompanyDetailScreen(company: company),
              );

            /// CompanyEditScreen
            case CompanyEditScreen.route:
              final company = settings.arguments as Company?;
              return MaterialPageRoute(
                builder: (context) =>
                    CompanyEditScreen(initialCompany: company),
              );

            /// Default
            default:
              return MaterialPageRoute(
                builder: (context) => const MainScreen(),
              );
          }
        },
      ),
    );
  }
}
