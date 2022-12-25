import 'package:flutter/material.dart';

import '../../domain/entities/vacancy.dart';
import 'vacancy_list_tile.dart';

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
        return VacancyListTile(
          vacancy: vacancy,
        );
      },
    );
  }
}
