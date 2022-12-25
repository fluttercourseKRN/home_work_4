import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/vacancy_item_provider.dart';
import '../screens/vacancy_detail_screen.dart';
import 'favorite_button.dart';

class VacancyListTile extends StatelessWidget {
  const VacancyListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<VacancyItemProvider>(
      builder: (context, vacancyItem, child) {
        return ListTile(
          title: Text(vacancyItem.vacancy.title),
          subtitle: Text(vacancyItem.vacancy.city),
          trailing: FavoriteButton(
            value: vacancyItem.vacancy.isFavorite,
            onTap: () => vacancyItem.toggleFavorite(),
          ),
          onTap: () => Navigator.of(context).pushNamed(
            VacancyDetailScreen.route,
            arguments: vacancyItem.vacancy,
          ),
        );
      },
    );
  }
}
