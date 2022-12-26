import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jobsin/presentation/providers/abstract/menu_controller_mixin.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/vacancy.dart';
import '../../domain/model/enums/vacancies_sort_element.dart';
import '../../domain/usecases/get_vacancies_list.dart';

class VacanciesProvider extends ChangeNotifier
    with MenuControllerMixin<VacanciesSortElement> {
  VacanciesProvider({
    required this.context,
    required this.useCaseGetVacanciesList,
  }) {
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

// import 'package:collection/collection.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../domain/entities/vacancy.dart';
// import '../../domain/model/enums/vacancies_sort_element.dart';
// import '../../domain/usecases/get_vacancies_list.dart';
//
// class VacanciesProvider with ChangeNotifier {
//   VacanciesProvider({
//     required this.getVacanciesList,
//   }) : vacanciesSortField = VacanciesSortElement.values.first {
//     _fetchVacancies();
//   }
//
//   factory VacanciesProvider.read(BuildContext context) =>
//       context.read<VacanciesProvider>();
//
//   factory VacanciesProvider.watch(BuildContext context) =>
//       context.watch<VacanciesProvider>();
//   //////////////////////////////////////////////////////////////////////////////
//   // UseCases
//   final GetVacanciesList getVacanciesList;
//   List<Vacancy> vacancies = [];
//
//   @override
//   void notifyListeners() => _fetchVacancies();
//
//   Future<void> _fetchVacancies() async {
//     final vacanciesListOrFailure = await getVacanciesList(
//       VacanciesParams(
//         favoritesOnly: vacanciesShowFavoriteOnly,
//         sortElement: vacanciesSortField,
//       ),
//     );
//     vacanciesListOrFailure.fold(
//       (l) => vacancies = [],
//       (r) => vacancies = [...r],
//     );
//     print(vacancies);
//     super.notifyListeners();
//   }
//
//   Vacancy? vacancyForId(int vacancyId) {
//     return vacancies.firstWhereOrNull((vacancy) => vacancy.id == vacancyId);
//   }
//
//   Future<List<Vacancy>> vacanciesForCompany(int companyId) async {
//     // final vacancies = await repository.getVacanciesForCompany(companyId);
//     return [];
//   }
//
//   /// MARK: Add new
//   void saveNewVacancy(String title, String city, String description) {}
//
//   List<int>? fetchCompaniesId;
//   /// MARK: AppMenu state //////////////////////////////////////////////////////
//   // Show favorite vacancies
//   bool vacanciesShowFavoriteOnly = false;
//   void toggleVacanciesShowFavoriteOnly() {
//     vacanciesShowFavoriteOnly = !vacanciesShowFavoriteOnly;
//     notifyListeners();
//   }
//
//   // Sort vacancies
//   VacanciesSortElement vacanciesSortField;
//   void setVacanciesSortField(VacanciesSortElement field) {
//     vacanciesSortField = field;
//     notifyListeners();
//   }
// }
