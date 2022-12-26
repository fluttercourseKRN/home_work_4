import 'package:flutter/material.dart';

import 'domain/entities/company.dart';
import 'domain/entities/vacancy.dart';
import 'injector_container.dart' as di;
import 'presentation/screens/company_detail_screen.dart';
import 'presentation/screens/company_edit_screen.dart';
import 'presentation/screens/main_screen.dart';
import 'presentation/screens/vacancy_detail_screen.dart';
import 'presentation/screens/vacancy_edit_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.setUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
              builder: (context) => VacancyEditScreen(initialVacancy: vacancy),
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
              builder: (context) => CompanyEditScreen(initialCompany: company),
            );

          /// Default
          default:
            return MaterialPageRoute(
              builder: (context) => const MainScreen(),
            );
        }
      },
    );
  }
}
