import 'package:flutter/material.dart';
import 'package:jobsin/presentation/providers/data_provider.dart';

import '../../domain/model/vacancy.dart';
import '../screens/vacancy_detail_screen.dart';

class VacancyListTile extends StatelessWidget {
  const VacancyListTile({
    Key? key,
    required this.vacancy,
  }) : super(key: key);

  final Vacancy vacancy;

  @override
  Widget build(BuildContext context) {
    print('id:${vacancy.id} isFavorite: ${vacancy.isFavorite}');
    return ListTile(
      title: Text(vacancy.title),
      subtitle: Text(vacancy.city),
      trailing: IconButton(
        onPressed: () {
          DataProvider.read(context).toggleVacancyToFavorite(vacancy.id);
        },
        icon: vacancy.isFavorite
            ? const Icon(Icons.star, color: Colors.orange)
            : const Icon(Icons.star_border),
      ),
      onTap: () => Navigator.of(context).pushNamed(
        VacancyDetailScreen.route,
        arguments: vacancy,
      ),
    );
  }
}
