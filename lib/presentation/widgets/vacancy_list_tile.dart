import 'package:flutter/material.dart';
import 'package:jobsin/domain/entities/vacancy.dart';
import 'package:jobsin/presentation/providers/vacancies_provider.dart';
import 'package:jobsin/presentation/widgets/favorite_button.dart';

import '../screens/vacancy_detail_screen.dart';

class VacancyListTile extends StatelessWidget {
  const VacancyListTile({
    Key? key,
    required this.vacancy,
  }) : super(key: key);

  final Vacancy vacancy;
  @override
  Widget build(BuildContext context) {
    // final vacancy = VacancyItemProvider.watch(context).vacancy;
    return ListTile(
      title: Text(vacancy.title),
      subtitle: Text(vacancy.city),
      trailing: FavoriteButton(
        value: vacancy.isFavorite,
        onTap: () => VacanciesProvider.read(context).setIsFavoriteFor(
          vacancyId: vacancy.id,
          value: !vacancy.isFavorite,
        ),
      ),
      onTap: () => Navigator.of(context).pushNamed(
        VacancyDetailScreen.route,
        arguments: vacancy,
      ),
    );
  }
}
