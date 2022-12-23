import 'package:flutter/material.dart';
import 'package:jobsin/presentation/providers/vacancy_item_provider.dart';
import 'package:jobsin/presentation/widgets/favorite_button.dart';

import '../screens/vacancy_detail_screen.dart';

class VacancyListTile extends StatelessWidget {
  const VacancyListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vacancy = VacancyItemProvider.watch(context).vacancy;
    return ListTile(
      title: Text(vacancy.title),
      subtitle: Text(vacancy.city),
      trailing: FavoriteButton(
        value: vacancy.isFavorite,
        onTap: () => VacancyItemProvider.read(context).toggleIsFavorite(),
      ),
      onTap: () => Navigator.of(context).pushNamed(
        VacancyDetailScreen.route,
        arguments: vacancy,
      ),
    );
  }
}
