import 'package:flutter/material.dart';
import 'package:jobsin/data/remote/repositories/remote_repository.dart';
import 'package:jobsin/domain/model/vacancy.dart';
import 'package:jobsin/presentation/providers/data_provider.dart';
import 'package:jobsin/presentation/screens/vacancy_detail_screen.dart';
import 'package:provider/provider.dart';

import 'presentation/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DataProvider>(
          create: (context) => DataProvider(repository: RemoteRepository()),
        ),
      ],
      child: MaterialApp(
        title: 'JobsIn',
        theme: ThemeData(
          primarySwatch: Colors.blue,
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
