import 'package:flutter/material.dart';
import 'package:jobsin/domain/usecases/delete_vacancy.dart';
import 'package:jobsin/domain/usecases/get_my_companies.dart';
import 'package:jobsin/domain/usecases/get_my_vacancies.dart';
import 'package:jobsin/presentation/providers/menu_provider.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/company.dart';
import '../../domain/entities/vacancy.dart';
import '../../domain/model/enums/vacancies_sort_element.dart';
import '../../domain/usecases/add_vacancy.dart';
import '../../domain/usecases/get_vacancies_list.dart';

class VacanciesProvider extends ChangeNotifier {
  VacanciesProvider({
    required this.context,
    required this.useCaseGetMyVacancies,
    required this.useCaseGetMyCompanies,
    required this.useCaseAddVacancy,
    required this.useCaseDeleteVacancy,
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

  List<int>? fetchOnlyCompaniesId;
  // UseCases
  final GetVacanciesList useCaseGetVacanciesList;
  final GetMyVacancies useCaseGetMyVacancies;
  final AddVacancy useCaseAddVacancy;
  final DeleteVacancy useCaseDeleteVacancy;
  final GetMyCompanies useCaseGetMyCompanies;

  List<Vacancy>? vacancies;
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

  Future<List<Vacancy>> getMyVacancies() async {
    // final vacancies = await repository.getVacanciesForCompany(companyId);
    return [];
  }

  Future<List<Company>> getMyCompanies() async {
    final companiesOrFailure = await useCaseGetMyCompanies(null);

    return companiesOrFailure.fold(
      (l) {
        return [];
      },
      (r) {
        return r;
      },
    );
  }

  /// MARK: Add new
  Future<void> addNewVacancy(
    int companyId,
    String title,
    String city,
    String description,
  ) async {
    final res = await useCaseAddVacancy(
      AddVacancyParam(
        vacancy: Vacancy(
          id: 0,
          companyId: companyId,
          city: city,
          title: title,
          description: description,
          isOwner: true,
          isFavorite: false,
        ),
      ),
    );
    res.fold((l) => print(l), (r) => print(r));
    _fetchVacancies();
  }

  Future<void> deleteVacancy(int vacancyId) async {
    await useCaseDeleteVacancy(DeleteVacancyParam(vacancyId: vacancyId));
    _fetchVacancies();
  }
}
