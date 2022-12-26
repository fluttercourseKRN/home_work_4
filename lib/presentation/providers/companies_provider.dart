import 'package:flutter/material.dart';
import 'package:jobsin/domain/usecases/get_companies_list.dart';
import 'package:jobsin/presentation/providers/abstract/menu_controller_mixin.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/company.dart';
import '../../domain/model/enums/companies_sort_element.dart';

class CompaniesProvider extends ChangeNotifier
    with MenuControllerMixin<CompaniesSortElement> {
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

  @override
  CompaniesSortElement initSortType() => CompaniesSortElement.values.first;

  final GetCompaniesList useCaseGetCompaniesList;
  List<Company>? companies = [];

  @override
  void notifyListeners() => _fetchCompanies();

  Future<void> _fetchCompanies({bool isShowLoading = true}) async {
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

    super.notifyListeners();
  }

  /// MARK: Add new entities
  void saveNewCompany(String name, String description, String industry) {}

  // // Show favorite companies
  // bool companiesShowFavoriteOnly = false;
  // void toggleCompaniesShowFavoriteOnly() {
  //   companiesShowFavoriteOnly = !companiesShowFavoriteOnly;
  //   notifyListeners();
  // }
  //
  // // Sort companies
  // CompaniesSortElement companiesSortField;
  // void setCompaniesSortField(CompaniesSortElement field) {
  //   companiesSortField = field;
  //   notifyListeners();
  // }
}
