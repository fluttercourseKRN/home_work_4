import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jobsin/presentation/widgets/vacancies_list.dart';

import '../../domain/entities/vacancy.dart';
import '../../domain/model/enums/vacancies_sort_element.dart';
import '../../domain/model/sort_element.dart';
import '../providers/data_provider.dart';
import '../widgets/app_menu.dart';

class VacanciesScreen extends StatelessWidget {
  const VacanciesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppMenu(
          sortElements: VacanciesSortElement.values,
          currentSortField: DataProvider.watch(context).vacanciesSortField,
          onSortFieldChange: (SortElement value) =>
              DataProvider.read(context).setVacanciesSortField(value),
          isOn: DataProvider.watch(context).vacanciesShowFavoriteOnly,
          switchChange: (bool value) =>
              DataProvider.read(context).toggleVacanciesShowFavoriteOnly(),
        ),
        const Divider(),
        Expanded(
          child: FutureBuilder<List<Vacancy>>(
            future: DataProvider.watch(context).vacancies,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final vacancies = snapshot.data!;
                return VacanciesList(vacancies: vacancies);
              }
              return Center(
                child:
                    SpinKitWave(color: Theme.of(context).colorScheme.primary),
              );
            },
          ),
        ),
      ],
    );
  }
}
