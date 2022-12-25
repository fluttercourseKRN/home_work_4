import 'package:flutter/material.dart';
import 'package:jobsin/domain/usecases/save_vacancy_favorite_status.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/vacancy.dart';
import '../../domain/model/enums/vacancies_sort_element.dart';
import '../../domain/usecases/get_vacancies_list.dart';
import '../../injector_container.dart';

class VacanciesProvider with ChangeNotifier {
  VacanciesProvider() : vacanciesSortField = VacanciesSortElement.values.first {
    _fetchVacancies();
  }

  factory VacanciesProvider.read(BuildContext context) =>
      context.read<VacanciesProvider>();

  factory VacanciesProvider.watch(BuildContext context) =>
      context.watch<VacanciesProvider>();

  List<Vacancy> vacancies = [];

  @override
  void notifyListeners() => _fetchVacancies();

  Future<void> _fetchVacancies() async {
    final getVacanciesList = sl<GetVacanciesList>();
    final vacanciesListOrFailure = await getVacanciesList(
      VacanciesParams(
        favoritesOnly: vacanciesShowFavoriteOnly,
        sortElement: vacanciesSortField,
      ),
    );
    vacanciesListOrFailure.fold(
      (l) => vacancies = [],
      (r) => vacancies = [...r],
    );

    super.notifyListeners();
  }

  // Future<Vacancy?> vacancyForId(int vacancyId) async {
  //   final vacancies = await repository.getVacancies();
  //   return vacancies.firstWhereOrNull((vacancy) => vacancy.id == vacancyId);
  // }

  Future<List<Vacancy>> vacanciesForCompany(int companyId) async {
    // final vacancies = await repository.getVacanciesForCompany(companyId);
    return [];
  }

  /// MARK: Add new
  void saveNewVacancy(String title, String city, String description) {}

  ///MARK: Favorite
  Future<void> setIsFavoriteFor({
    required int vacancyId,
    required bool value,
  }) async {
    final setVacancyFavoriteStatus = sl<SetVacancyFavoriteStatus>();
    await setVacancyFavoriteStatus(
      VacancyFavoriteParams(vacancyId: vacancyId, value: value),
    );
    notifyListeners();
  }

  /// MARK: AppMenu state //////////////////////////////////////////////////////
  // Show favorite vacancies
  bool vacanciesShowFavoriteOnly = false;
  void toggleVacanciesShowFavoriteOnly() {
    vacanciesShowFavoriteOnly = !vacanciesShowFavoriteOnly;
    notifyListeners();
  }

  // Sort vacancies
  VacanciesSortElement vacanciesSortField;
  void setVacanciesSortField(VacanciesSortElement field) {
    vacanciesSortField = field;
    notifyListeners();
  }
}
