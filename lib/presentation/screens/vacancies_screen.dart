import 'package:flutter/material.dart';
import 'package:jobsin/presentation/widgets/app_spinkit.dart';
import 'package:jobsin/presentation/widgets/vacancies_list.dart';
import 'package:provider/provider.dart';

import '../../domain/model/enums/vacancies_sort_element.dart';
import '../providers/vacancies_provider.dart';
import '../widgets/app_menu.dart';

class VacanciesScreen extends StatelessWidget {
  const VacanciesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppMenu<VacanciesSortElement>(
          sortElements: VacanciesSortElement.values,
          currentSortField: VacanciesProvider.watch(context).vacanciesSortField,
          onSortFieldChange: (VacanciesSortElement value) =>
              VacanciesProvider.read(context).setVacanciesSortField(value),
          isOn: VacanciesProvider.watch(context).vacanciesShowFavoriteOnly,
          switchChange: (bool value) =>
              VacanciesProvider.read(context).toggleVacanciesShowFavoriteOnly(),
        ),
        const Divider(),
        Expanded(
          child: Consumer<VacanciesProvider>(
            builder: (context, vacanciesProvider, child) {
              final vacancies = vacanciesProvider.vacancies;
              print(vacancies);
              if (vacancies.isNotEmpty) {
                return VacanciesList(vacancies: vacancies);
              } else {
                return const AppSpinkit();
              }
            },
          ),
        ),
      ],
    );
  }
}
