import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jobsin/presentation/providers/abstract/menu_controller_mixin.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/vacancy.dart';
import '../../domain/model/enums/vacancies_sort_element.dart';
import '../../domain/usecases/get_vacancies_list.dart';

class VacanciesProvider extends ChangeNotifier
    with MenuControllerMixin<VacanciesSortElement> {
  VacanciesProvider(
      {required this.context,
      required this.useCaseGetVacanciesList,
      this.fetchOnlyCompaniesId}) {
    _fetchVacancies();
  }

  factory VacanciesProvider.read(BuildContext context) =>
      context.read<VacanciesProvider>();

  factory VacanciesProvider.watch(BuildContext context) =>
      context.watch<VacanciesProvider>();
  //////////////////////////////////////////////////////////////////////////////
  @override
  void notifyListeners() => _fetchVacancies();

  @override
  VacanciesSortElement initSortType() => VacanciesSortElement.values.first;
  final BuildContext context;

  // UseCases
  final GetVacanciesList useCaseGetVacanciesList;
  List<Vacancy>? vacancies;
  List<int>? fetchOnlyCompaniesId;

  Future<void> _fetchVacancies({bool isShowLoading = true}) async {
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
    super.notifyListeners();
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
