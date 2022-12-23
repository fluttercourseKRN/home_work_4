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

  Repository repository;

  Future<List<Vacancy>> get vacancies async {
    final vacancies = await repository.getVacancies();
    switch (vacanciesSortField) {
      case VacanciesSortElement.title:
        vacancies.sort((a, b) => a.title.compareTo(b.title));
        break;
      case VacanciesSortElement.city:
        vacancies.sort((a, b) => a.city.compareTo(b.city));
        break;
    }
    for (var favoriteId in favoriteVacanciesIds) {
      print('favorite id: $favoriteId');
      vacancies.firstWhere((vacancy) {
        return vacancy.id == favoriteId;
      }).isFavorite = true;
    }
    return [...vacancies];
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

  List<int> favoriteVacanciesIds = [];
  void toggleVacancyToFavorite(int vacancyId) {
    if (favoriteVacanciesIds.contains(vacancyId)) {
      favoriteVacanciesIds.remove(vacancyId);
    } else {
      favoriteVacanciesIds.add(vacancyId);
    }
    notifyListeners();
  }

  void saveNewCompany(String name, String description, String industry) {}
  void saveNewVacancy(String title, String city, String description) {}
}
