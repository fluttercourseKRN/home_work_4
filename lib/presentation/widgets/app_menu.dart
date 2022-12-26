import 'package:flutter/material.dart';

import '../../domain/model/sort_element.dart';
import '../providers/abstract/menu_controller_mixin.dart';

class AppMenu extends StatelessWidget {
  const AppMenu({
    Key? key,
    required this.menuController,
  }) : super(key: key);

  final MenuControllerMixin menuController;
  @override
  Widget build(BuildContext context) {
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
                  menuController.itemSortField.text,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              ],
            ),
          ),
          itemBuilder: (context) {
            return [
              for (final value in menuController.itemSortField.possibleValues)
                PopupMenuItem<SortElement>(
                  child: Text(value.text),
                  onTap: () => menuController.setItemsSortField(value),
                )
            ];
          },
        ),
      ),
      trailing: Switch(
        activeColor: Theme.of(context).colorScheme.primary,
        onChanged: (_) => menuController.toggleItemsShowFavoriteOnly(),
        value: menuController.itemsShowFavoriteOnly,
      ),
    );
  }
}
