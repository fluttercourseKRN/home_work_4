import 'package:flutter/material.dart';
import 'package:jobsin/domain/entities/vacancy.dart';
import 'package:jobsin/domain/model/enums/companies_sort_element.dart';
import 'package:jobsin/domain/repositories/repository.dart';
import 'package:jobsin/domain/usecases/get_vacancies_list.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/company.dart';
import '../../domain/model/enums/vacancies_sort_element.dart';
import '../../domain/model/sort_element.dart';
import '../../injector_container.dart';

class DataProvider with ChangeNotifier {
  DataProvider({
    required this.repository,
  })  : vacanciesSortField = VacanciesSortElement.values.first,
        companiesSortField = CompaniesSortElement.values.first;

  factory DataProvider.read(BuildContext context) =>
      context.read<DataProvider>();

  factory DataProvider.watch(BuildContext context) =>
      context.watch<DataProvider>();

  final Repository repository;

  // Future<List<Vacancy>> get vacancies async {
  //   final vacancies = await repository.getVacancies();
  //   _sortVacancies(vacancies);
  //   return [..._vacanciesFavoriteFilter(vacancies)];
  // }

  Future<List<Vacancy>> getVacancies() async {
    final getVacanciesList = sl<GetVacanciesList>();
    final vacanciesListOrFailure = await getVacanciesList(
      VacanciesParams(
        favoritesOnly: vacanciesShowFavoriteOnly,
        sortElement: vacanciesSortField as VacanciesSortElement,
      ),
    );
    return vacanciesListOrFailure.fold((l) => [], (r) => r);
  }

  // Future<Vacancy?> vacancyForId(int vacancyId) async {
  //   final vacancies = await repository.getVacancies();
  //   return vacancies.firstWhereOrNull((vacancy) => vacancy.id == vacancyId);
  // }

  Future<List<Vacancy>> vacanciesForCompany(int companyId) async {
    final vacancies = await repository.getVacanciesForCompany(companyId);
    return [...vacancies];
  }

  Future<List<Company>> get companies async {
    final companies = await repository.getCompanies();
    _sortCompanies(companies);

    return [..._companiesFavoriteFilter(companies)];
  }

  /// MARK: Add new entities
  void saveNewCompany(String name, String description, String industry) {}
  void saveNewVacancy(String title, String city, String description) {}

  /// MARK: AppMenu state //////////////////////////////////////////////////////
  // Show favorite vacancies
  bool vacanciesShowFavoriteOnly = false;
  void toggleVacanciesShowFavoriteOnly() {
    vacanciesShowFavoriteOnly = !vacanciesShowFavoriteOnly;
    notifyListeners();
  }

  // Sort vacancies
  SortElement vacanciesSortField;
  void setVacanciesSortField(SortElement field) {
    vacanciesSortField = field;
    notifyListeners();
  }

  // Show favorite companies
  bool companiesShowFavoriteOnly = false;
  void toggleCompaniesShowFavoriteOnly() {
    companiesShowFavoriteOnly = !companiesShowFavoriteOnly;
    notifyListeners();
  }

  List<Company> _companiesFavoriteFilter(List<Company> companies) {
    if (companiesShowFavoriteOnly) {
      return [...companies.where((company) => company.isFavorite == true)];
    } else {
      return [...companies];
    }
  }

  // Sort companies
  SortElement companiesSortField;
  void setCompaniesSortField(SortElement field) {
    companiesSortField = field;
    notifyListeners();
  }

  void _sortCompanies(List<Company> companies) {
    switch (companiesSortField) {
      case CompaniesSortElement.name:
        companies.sort((a, b) => a.name.compareTo(b.name));
        break;
      case CompaniesSortElement.industry:
        companies.sort((a, b) => a.industry.compareTo(b.industry));
        break;
    }
  }
}
