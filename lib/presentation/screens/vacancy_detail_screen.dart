import 'package:flutter/material.dart';
import 'package:jobsin/domain/model/vacancy.dart';

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
      appBar: AppBar(title: const Text("Вакансії")),
      body: SafeArea(
        child: Center(
          child: Text(vacancy.description),
        ),
      ),
    );
  }
}
