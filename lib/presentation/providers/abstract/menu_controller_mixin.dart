import 'package:flutter/material.dart';
import 'package:jobsin/domain/model/sort_element.dart';

mixin MenuControllerMixin<SortType extends SortElement> on ChangeNotifier {
  bool itemsShowFavoriteOnly = false;
  void toggleItemsShowFavoriteOnly() {
    itemsShowFavoriteOnly = !itemsShowFavoriteOnly;
    notifyListeners();
  }

  // Sort vacancies
  SortType initSortType();
  late SortType itemSortField = initSortType();
  void setItemsSortField(SortType field) {
    itemSortField = field;
    notifyListeners();
  }
}
