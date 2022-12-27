import 'package:flutter/material.dart';
import 'package:jobsin/presentation/providers/menu_provider.dart';
import 'package:provider/provider.dart';

import '../../domain/model/sort_element.dart';

class AppMenu<T extends SortElement> extends StatelessWidget {
  const AppMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuProvider<T>>(
      builder: (context, menuProvider, child) {
        return ListTile(
          leading: SizedBox(
            width: 150,
            child: PopupMenuButton<SortElement>(
              position: PopupMenuPosition.under,
              child: Center(
                child: Row(
                  children: [
                    const Text(
                      "Sort by: ",
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      menuProvider.itemSortField.text,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )
                  ],
                ),
              ),
              itemBuilder: (context) {
                return [
                  for (final value in menuProvider.itemSortField.possibleValues)
                    PopupMenuItem<T>(
                      child: Text(value.text),
                      onTap: () => menuProvider.setItemsSortField(value as T),
                    )
                ];
              },
            ),
          ),
          trailing: Switch(
            activeColor: Theme.of(context).colorScheme.primary,
            onChanged: (_) => menuProvider.toggleItemsShowFavoriteOnly(),
            value: menuProvider.itemsShowFavoriteOnly,
          ),
        );
      },
    );
  }
}
