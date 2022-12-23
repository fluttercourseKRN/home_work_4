import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jobsin/domain/model/entities/vacancy.dart';
import 'package:jobsin/domain/model/enums/companies_sort_element.dart';
import 'package:jobsin/domain/repositories/repository.dart';
import 'package:provider/provider.dart';

import '../../domain/model/entities/company.dart';
import '../../domain/model/enums/vacancies_sort_element.dart';
import '../../domain/model/sort_element.dart';

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

  Future<List<Vacancy>> get vacancies async {
    final vacancies = await repository.getVacancies();
    _sortVacancies(vacancies);
    return [..._vacanciesFavoriteFilter(vacancies)];
  }

  Future<Vacancy?> vacancyForId(int vacancyId) async {
    final vacancies = await repository.getVacancies();
    return vacancies.firstWhereOrNull((vacancy) => vacancy.id == vacancyId);
  }

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

  List<Vacancy> _vacanciesFavoriteFilter(List<Vacancy> vacancies) {
    if (vacanciesShowFavoriteOnly) {
      return [...vacancies.where((vacancy) => vacancy.isFavorite == true)];
    } else {
      return [...vacancies];
    }
  }

  // Sort vacancies
  SortElement vacanciesSortField;
  void setVacanciesSortField(SortElement field) {
    vacanciesSortField = field;
    notifyListeners();
  }

  void _sortVacancies(List<Vacancy> vacancies) {
    switch (vacanciesSortField) {
      case VacanciesSortElement.title:
        vacancies.sort((a, b) => a.title.compareTo(b.title));
        break;
      case VacanciesSortElement.city:
        vacancies.sort((a, b) => a.city.compareTo(b.city));
        break;
    }
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
