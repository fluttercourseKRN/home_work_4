import 'package:flutter/material.dart';
import 'package:jobsin/presentation/providers/vacancy_item_provider.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/vacancy.dart';
import '../../domain/usecases/toggle_vacancy_favorite_status.dart';
import '../../injector_container.dart';
import '../models/vacancy_presentation.dart';
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
      shrinkWrap: true,
      itemCount: vacancies.length,
      itemBuilder: (context, index) {
        final vacancy = vacancies[index];
        return ChangeNotifierProvider<VacancyItemProvider>(
          key: ValueKey(vacancy.id),
          create: (context) => VacancyItemProvider(
            context: context,
            element: VacancyPresentation.fromVacancy(vacancy),
            toggleUseCase: sl<ToggleVacancyFavoriteStatus>(),
          ),
          child: const VacancyListTile(),
        );
      },
    );
  }
}
