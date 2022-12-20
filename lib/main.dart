import 'package:flutter/material.dart';
import 'package:jobsin/presentation/providers/data_provider.dart';
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<DataProvider>(
            create: (context) {
              return DataProvider();
            },
          ),
        ],
        child: const MainScreen(),
      ),
    );
  }
}
