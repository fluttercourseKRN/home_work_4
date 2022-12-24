import 'package:flutter/material.dart';
import 'package:jobsin/domain/entities/vacancy.dart';
import 'package:jobsin/presentation/widgets/app_bar_main.dart';

class VacancyDetailScreen extends StatelessWidget {
  const VacancyDetailScreen({
    Key? key,
    required this.vacancy,
  }) : super(key: key);

  static const route = '/vacancy_detail_screen';

  final Vacancy vacancy;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarMain(),
      body: SafeArea(
        child: Center(
          child: Text(vacancy.description),
        ),
      ),
    );
  }
}
