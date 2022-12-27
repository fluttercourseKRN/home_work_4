import 'package:flutter/material.dart';
import 'package:jobsin/domain/model/enums/vacancies_sort_element.dart';
import 'package:provider/provider.dart';

import '../providers/vacancies_provider.dart';
import '../widgets/app_menu.dart';
import '../widgets/app_spinkit.dart';
import '../widgets/vacancies_list.dart';

class VacanciesScreen extends StatelessWidget {
  const VacanciesScreen({
    Key? key,
    this.showMenu = true,
  }) : super(key: key);

  final bool showMenu;
  @override
  Widget build(BuildContext context) {
    return Consumer<VacanciesProvider>(
      builder: (context, vacanciesProvider, child) {
        final vacancies = vacanciesProvider.vacancies;

        return Column(
          children: [
            if (showMenu) const AppMenu<VacanciesSortElement>(),
            const Divider(),
            if (vacancies == null) const Expanded(child: AppSpinkit()),
            if (vacancies != null)
              Expanded(child: VacanciesList(vacancies: vacancies)),
          ],
        );
      },
    );
  }
}
