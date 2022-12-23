import 'package:flutter/material.dart';
import 'package:jobsin/presentation/providers/data_provider.dart';

class AppMenu extends StatelessWidget {
  const AppMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 100,
        child: PopupMenuButton<VacanciesSortElement>(
          position: PopupMenuPosition.under,
          child: Center(
            child: Row(
              children: [
                const Text(
                  "Sort by: ",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  DataProvider.watch(context).vacanciesSortField.name,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              ],
            ),
          ),
          itemBuilder: (context) {
            return [
              for (final value in VacanciesSortElement.values)
                PopupMenuItem<VacanciesSortElement>(
                  child: Text(value.name),
                  onTap: () {
                    DataProvider.read(context).setVacanciesSortField(value);
                    // print(value);
                  },
                )
            ];
          },
        ),
      ),
      trailing: Switch(
        activeColor: Theme.of(context).colorScheme.primary,
        onChanged: (_) {
          DataProvider.read(context).toggleVacanciesFavorite();
        },
        value: DataProvider.watch(context).vacanciesFavoritesOnly,
      ),
    );
  }
}
