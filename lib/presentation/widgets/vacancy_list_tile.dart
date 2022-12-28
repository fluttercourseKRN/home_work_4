import 'package:flutter/material.dart';
import 'package:jobsin/presentation/providers/vacancy_item_provider.dart';
import 'package:provider/provider.dart';

import '../screens/vacancy_detail_screen.dart';
import 'favorite_icon_button.dart';

class VacancyListTile extends StatelessWidget {
  const VacancyListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<VacancyItemProvider>(
      builder: (context, vacancyItem, child) {
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
              if (vacancyItem.element.isOwner)
                Icon(
                  Icons.house_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
            ],
          ),
          subtitle: Text(vacancyItem.element.city),
          trailing: FavoriteIconButton(
            value: vacancyItem.element.isFavorite,
            onTap: () => vacancyItem.toggleFavorite(),
          ),
          onTap: () => Navigator.of(context).pushNamed(
            VacancyDetailScreen.route,
            arguments: vacancyItem.element,
          ),
        );
      },
    );
  }
}
