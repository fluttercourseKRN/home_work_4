import 'package:flutter/material.dart';
import 'package:jobsin/presentation/providers/vacancies_provider.dart';
import 'package:jobsin/presentation/providers/vacancy_item_provider.dart';
import 'package:jobsin/presentation/screens/vacancy_edit_screen.dart';
import 'package:jobsin/presentation/widgets/edit_icon_button.dart';
import 'package:provider/provider.dart';

import '../screens/vacancy_detail_screen.dart';
import 'delete_icon_button.dart';
import 'favorite_icon_button.dart';

class VacancyListTile extends StatelessWidget {
  const VacancyListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<VacancyItemProvider>(
      builder: (context, vacancyItem, child) {
        final favoriteButton = FavoriteIconButton(
          value: vacancyItem.element.isFavorite,
          onTap: () => vacancyItem.toggleFavorite(),
        );

        final deleteButton = DeleteIconButton(
          onTap: () => VacanciesProvider.read(context)
              .deleteVacancy(vacancyItem.element.id),
        );

        final editButton = EditIconButton(onTap: () {
          Navigator.of(context).pushNamed(
            VacancyEditScreen.route,
            arguments: vacancyItem.element,
          );
        });
        return ListTile(
          title: Row(
            children: [
              if (vacancyItem.element.isOwner)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.house_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              Flexible(
                child: Text(
                  vacancyItem.element.title,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          subtitle: Text(vacancyItem.element.city),
          trailing: vacancyItem.element.isOwner
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [editButton, deleteButton],
                )
              : favoriteButton,
          onTap: () => Navigator.of(context).pushNamed(
            VacancyDetailScreen.route,
            arguments: vacancyItem.element,
          ),
        );
      },
    );
  }
}
