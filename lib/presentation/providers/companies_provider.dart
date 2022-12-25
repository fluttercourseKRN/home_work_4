import 'package:flutter/material.dart';
import 'package:jobsin/domain/usecases/get_companies_list.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/company.dart';
import '../../domain/model/enums/companies_sort_element.dart';

class CompaniesProvider with ChangeNotifier {
  CompaniesProvider({
    required this.getCompaniesList,
  }) : companiesSortField = CompaniesSortElement.values.first {
    _fetchCompanies();
  }

  factory CompaniesProvider.read(BuildContext context) =>
      context.read<CompaniesProvider>();

  factory CompaniesProvider.watch(BuildContext context) =>
      context.watch<CompaniesProvider>();
  //////////////////////////////////////////////////////////////////////////////
  final GetCompaniesList getCompaniesList;
  List<Company> companies = [];

  @override
  void notifyListeners() => _fetchCompanies();

  Future<void> _fetchCompanies() async {
    final vacanciesListOrFailure = await getCompaniesList(
      CompaniesParams(
        favoritesOnly: companiesShowFavoriteOnly,
        sortElement: companiesSortField,
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

  // Show favorite companies
  bool companiesShowFavoriteOnly = false;
  void toggleCompaniesShowFavoriteOnly() {
    companiesShowFavoriteOnly = !companiesShowFavoriteOnly;
    notifyListeners();
  }

  // Sort companies
  CompaniesSortElement companiesSortField;
  void setCompaniesSortField(CompaniesSortElement field) {
    companiesSortField = field;
    notifyListeners();
  }
}
