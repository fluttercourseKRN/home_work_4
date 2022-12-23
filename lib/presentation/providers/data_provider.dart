import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jobsin/domain/model/vacancy.dart';
import 'package:jobsin/domain/repositories/repository.dart';
import 'package:provider/provider.dart';

import '../../domain/model/company.dart';

enum VacanciesSortElement {
  title('Title'),
  city('City');

  final String name;
  const VacanciesSortElement(this.name);
}

class DataProvider with ChangeNotifier {
  DataProvider({required this.repository})
      : vacanciesSortField = VacanciesSortElement.values.first;

  factory DataProvider.read(BuildContext context) =>
      context.read<DataProvider>();

  factory DataProvider.watch(BuildContext context) =>
      context.watch<DataProvider>();

  final Repository repository;

  _sortVacancies(List<Vacancy> vacancies) {
    switch (vacanciesSortField) {
      case VacanciesSortElement.title:
        vacancies.sort((a, b) => a.title.compareTo(b.title));
        break;
      case VacanciesSortElement.city:
        vacancies.sort((a, b) => a.city.compareTo(b.city));
        break;
    }
  }

  Future<void> _checkFavorite(List<Vacancy> vacancies) async {
    final favoriteIds = await repository.getFavoriteVacancies();
    vacancies = vacancies.toSet().intersection(favoriteIds.toSet()).toList();
    // for (var vacancy in vacancies) {
    //   if(favoriteIds.contains(vacancy.id)){
    //     vacancy.isFavorite = true;
    //   }
    // }
  }

  Future<List<Vacancy>> get vacancies async {
    final vacancies = await repository.getVacancies();
    _sortVacancies(vacancies);
    await _checkFavorite(vacancies);
    return [...vacancies];
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
    return [...companies];
  }

  bool vacanciesFavoritesOnly = false;
  void toggleVacanciesFavorite() {
    vacanciesFavoritesOnly = !vacanciesFavoritesOnly;
    notifyListeners();
  }

  VacanciesSortElement vacanciesSortField;
  void setVacanciesSortField(VacanciesSortElement field) {
    vacanciesSortField = field;
    notifyListeners();
  }

  void saveNewCompany(String name, String description, String industry) {}
  void saveNewVacancy(String title, String city, String description) {}
}
