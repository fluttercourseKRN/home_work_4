import 'package:flutter/material.dart';
import 'package:jobsin/domain/usecases/get_companies_list.dart';
import 'package:jobsin/presentation/providers/menu_provider.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/company.dart';
import '../../domain/model/enums/companies_sort_element.dart';

class CompaniesProvider extends ChangeNotifier {
  CompaniesProvider({
    required this.useCaseGetCompaniesList,
  }) {
    _fetchCompanies();
  }

  factory CompaniesProvider.read(BuildContext context) =>
      context.read<CompaniesProvider>();

  factory CompaniesProvider.watch(BuildContext context) =>
      context.watch<CompaniesProvider>();
  //////////////////////////////////////////////////////////////////////////////

  final GetCompaniesList useCaseGetCompaniesList;
  List<Company>? companies;

  void menuUpdate(MenuProvider<CompaniesSortElement> menuProvider) {
    _fetchCompanies(
      itemsShowFavoriteOnly: menuProvider.itemsShowFavoriteOnly,
      itemSortField: menuProvider.itemSortField,
    );
  }

  Future<void> _fetchCompanies({
    bool itemsShowFavoriteOnly = false,
    CompaniesSortElement itemSortField = CompaniesSortElement.none,
    bool isShowLoading = true,
  }) async {
    if (isShowLoading) {
      companies = null;
      super.notifyListeners();
    }
    final vacanciesListOrFailure = await useCaseGetCompaniesList(
      CompaniesParams(
        favoritesOnly: itemsShowFavoriteOnly,
        sortElement: itemSortField,
      ),
    );
    vacanciesListOrFailure.fold(
      (l) => companies = [],
      (r) => companies = [...r],
    );

    notifyListeners();
  }

  /// MARK: Add new entities
  void saveNewCompany(String name, String description, String industry) {}
}
