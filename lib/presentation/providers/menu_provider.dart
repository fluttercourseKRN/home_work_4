import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/model/sort_element.dart';

class MenuProvider<SortType extends SortElement> extends ChangeNotifier {
  MenuProvider({
    required this.itemSortField,
  });
  factory MenuProvider.read(BuildContext context) =>
      context.read<MenuProvider<SortType>>();

  factory MenuProvider.watch(BuildContext context) =>
      context.watch<MenuProvider<SortType>>();

  bool itemsShowFavoriteOnly = false;
  void toggleItemsShowFavoriteOnly() {
    itemsShowFavoriteOnly = !itemsShowFavoriteOnly;
    notifyListeners();
  }

  SortType itemSortField;
  void setItemsSortField(SortType field) {
    itemSortField = field;
    notifyListeners();
  }
}
