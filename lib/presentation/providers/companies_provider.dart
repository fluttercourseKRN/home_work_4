import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/company.dart';
import '../../domain/model/enums/companies_sort_element.dart';
import '../../domain/model/sort_element.dart';

class CompaniesProvider with ChangeNotifier {
  CompaniesProvider() : companiesSortField = CompaniesSortElement.values.first {
    // _fetchVacancies();
  }

  factory CompaniesProvider.read(BuildContext context) =>
      context.read<CompaniesProvider>();

  factory CompaniesProvider.watch(BuildContext context) =>
      context.watch<CompaniesProvider>();

  List<Company> companies = [];

  @override
  void notifyListeners() {
    // _fetchVacancies();
    super.notifyListeners();
  }

  // Future<void> _fetchVacancies() async {
  //   final getVacanciesList = sl<GetVacanciesList>();
  //   final vacanciesListOrFailure = await getVacanciesList(
  //     VacanciesParams(
  //       favoritesOnly: vacanciesShowFavoriteOnly,
  //       sortElement: vacanciesSortField as VacanciesSortElement,
  //     ),
  //   );
  //   vacanciesListOrFailure.fold(
  //         (l) => vacancies = [],
  //         (r) => vacancies = [...r],
  //   );
  // }

  // Future<List<Company>> get companies async {
  //   final companies = await repository.getCompanies();
  //   _sortCompanies(companies);
  //
  //   return [..._companiesFavoriteFilter(companies)];
  // }

  ///MARK: Favorite
  // Future<void> setIsFavoriteFor({
  //   required int vacancyId,
  //   required bool value,
  // }) async {
  //   final setVacancyFavoriteStatus = sl<SetVacancyFavoriteStatus>();
  //   await setVacancyFavoriteStatus(
  //     VacancyFavoriteParams(vacancyId: vacancyId, value: value),
  //   );
  //   notifyListeners();
  // }

  /// MARK: Add new entities
  void saveNewCompany(String name, String description, String industry) {}

  // Show favorite companies
  bool companiesShowFavoriteOnly = false;
  void toggleCompaniesShowFavoriteOnly() {
    companiesShowFavoriteOnly = !companiesShowFavoriteOnly;
    notifyListeners();
  }

  // Sort companies
  SortElement companiesSortField;
  void setCompaniesSortField(SortElement field) {
    companiesSortField = field;
    notifyListeners();
  }
}
