import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            AppMenu(menuController: vacanciesProvider),
            const Divider(),
            Expanded(
              child: VacanciesList(vacancies: vacancies),
            ),
          ],
        );
      },
    );
  }
}
