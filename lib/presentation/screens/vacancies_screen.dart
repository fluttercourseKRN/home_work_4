import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jobsin/presentation/widgets/vacancies_list.dart';

import '../../domain/model/vacancy.dart';
import '../providers/data_provider.dart';

class VacanciesScreen extends StatelessWidget {
  const VacanciesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Vacancy>>(
      future: DataProvider.watch(context).vacancies,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final vacancies = snapshot.data!;
          return VacanciesList(vacancies: vacancies);
        }
        return Center(
          child: SpinKitWave(color: Theme.of(context).colorScheme.primary),
        );
      },
    );
  }
}
