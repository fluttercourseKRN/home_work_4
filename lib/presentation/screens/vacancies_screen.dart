import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/model/enums/vacancies_sort_element.dart';
import '../providers/vacancies_provider.dart';
import '../widgets/app_menu.dart';
import '../widgets/vacancies_list.dart';

class VacanciesScreen extends StatelessWidget {
  const VacanciesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<VacanciesProvider>(
      builder: (context, vacanciesProvider, child) {
        final vacancies = vacanciesProvider.vacancies;

        return Column(
          children: [
            AppMenu<VacanciesSortElement>(
              sortElements: VacanciesSortElement.values,
              currentSortField: vacanciesProvider.itemSortField,
              onSortFieldChange: (VacanciesSortElement value) =>
                  vacanciesProvider.setItemsSortField(value),
              isOn: vacanciesProvider.itemsShowFavoriteOnly,
              switchChange: (bool value) =>
                  vacanciesProvider.toggleItemsShowFavoriteOnly(),
            ),
            const Divider(),
            Expanded(child: VacanciesList(vacancies: vacancies)),
          ],
        );
      },
    );
  }
}
