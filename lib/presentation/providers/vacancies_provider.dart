import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jobsin/presentation/providers/menu_provider.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/vacancy.dart';
import '../../domain/model/enums/vacancies_sort_element.dart';
import '../../domain/usecases/get_vacancies_list.dart';

class VacanciesProvider extends ChangeNotifier {
  VacanciesProvider({
    required this.context,
    required this.useCaseGetVacanciesList,
    this.fetchOnlyCompaniesId,
  }) {
    _fetchVacancies();
  }

  factory VacanciesProvider.read(BuildContext context) =>
      context.read<VacanciesProvider>();

  factory VacanciesProvider.watch(BuildContext context) =>
      context.watch<VacanciesProvider>();
  //////////////////////////////////////////////////////////////////////////////
  final BuildContext context;
  List<Vacancy>? vacancies;
  List<int>? fetchOnlyCompaniesId;
  // UseCases
  final GetVacanciesList useCaseGetVacanciesList;

  void menuUpdate(MenuProvider<VacanciesSortElement> menuProvider) {
    _fetchVacancies(
      itemSortField: menuProvider.itemSortField,
      itemsShowFavoriteOnly: menuProvider.itemsShowFavoriteOnly,
    );
  }

  Future<void> _fetchVacancies({
    bool itemsShowFavoriteOnly = false,
    VacanciesSortElement itemSortField = VacanciesSortElement.none,
    bool isShowLoading = true,
  }) async {
    if (isShowLoading) {
      vacancies = null;
      super.notifyListeners();
    }

    final vacanciesListOrFailure = await useCaseGetVacanciesList(
      VacanciesParams(
        favoritesOnly: itemsShowFavoriteOnly,
        sortElement: itemSortField,
        fetchOnlyCompaniesId: fetchOnlyCompaniesId,
      ),
    );
    vacanciesListOrFailure.fold(
      (l) => vacancies = [],
      (r) => vacancies = [...r],
    );
    notifyListeners();
    // notifyListeners();
  }

  Vacancy? vacancyForId(int vacancyId) {
    return vacancies?.firstWhereOrNull((vacancy) => vacancy.id == vacancyId);
  }

  Future<List<Vacancy>> vacanciesForCompany(int companyId) async {
    // final vacancies = await repository.getVacanciesForCompany(companyId);
    return [];
  }

  /// MARK: Add new
  void saveNewVacancy(String title, String city, String description) {}
}
