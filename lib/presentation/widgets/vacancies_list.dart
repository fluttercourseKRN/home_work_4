import 'package:flutter/material.dart';
import 'package:jobsin/presentation/providers/vacancy_item_provider.dart';
import 'package:provider/provider.dart';

import '../../domain/model/entities/vacancy.dart';
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
        return ChangeNotifierProvider<VacancyItemProvider>(
          create: (context) => VacancyItemProvider(vacancy: vacancy),
          child: const VacancyListTile(),
        );
      },
    );
  }
}
