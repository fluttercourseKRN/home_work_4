import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../domain/model/vacancy.dart';
import '../../../providers/data_provider.dart';
import '../../vacancy_detail_screen.dart';

class VacanciesList extends StatelessWidget {
  const VacanciesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Vacancy>>(
      future: DataProvider.watch(context).vacancies,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final vacancies = snapshot.data!;
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
        return Center(
          child: SpinKitWave(color: Theme.of(context).colorScheme.primary),
        );
      },
    );
  }
}
