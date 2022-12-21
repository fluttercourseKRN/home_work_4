import 'package:flutter/material.dart';

import '../../domain/model/vacancy.dart';
import '../screens/vacancy_detail_screen.dart';

class VacanciesList extends StatelessWidget {
  const VacanciesList({
    Key? key,
    required this.vacancies,
  }) : super(key: key);

  final List<Vacancy> vacancies;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: vacancies.length,
      itemBuilder: (context, index) {
        final vacancy = vacancies[index];
        return ListTile(
          title: Text(vacancy.title),
          onTap: () => Navigator.of(context).pushNamed(
            VacancyDetailScreen.route,
            arguments: vacancy,
          ),
        );
      },
    );
  }
}
