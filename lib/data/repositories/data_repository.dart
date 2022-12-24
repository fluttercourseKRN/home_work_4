import 'package:dartz/dartz.dart';
import 'package:jobsin/core/error/failure.dart';
import 'package:jobsin/domain/repositories/repository.dart';

import '../../domain/entities/company.dart';
import '../../domain/entities/vacancy.dart';
import '../../domain/model/enums/vacancies_sort_element.dart';
import '../models/data_source_remote.dart';
import '../models/data_source_storage.dart';

class DataRepository extends Repository {
  final DataSourceRemote dataSourceRemote;
  final DataSourceStorage dataSourceStorage;

  DataRepository({
    required this.dataSourceRemote,
    required this.dataSourceStorage,
  });

  @override
  Future<List<Company>> getCompanies() async {
    final companyResponse = await dataSourceRemote.getCompanies();
    final companies = companyResponse?.companies ?? [];
    return await _setFavoriteCompany(companies);
  }

  Future<List<Company>> _setFavoriteCompany(List<Company> companies) async {
    final favoriteIds = await getFavoriteCompanies();
    for (final company in companies) {
      if (favoriteIds.contains(company.id)) {
        company.isFavorite = true;
      }
    }
    return [...companies];
  }

  @override
  Future<List<Vacancy>> getVacancies() async {
    final vacancyResponse = await dataSourceRemote.getVacancies();
    final vacancies = vacancyResponse ?? [];
    return await _setFavoriteVacancy(vacancies);
  }

  @override
  Future<List<Vacancy>> getVacanciesForCompany(int companyId) async {
    final vacancyResponse =
        await dataSourceRemote.getVacanciesForCompany(companyId);
    final vacancies = vacancyResponse ?? [];
    return await _setFavoriteVacancy(vacancies);
  }

  /// Favorite vacancy method
  @override
  Future<List<int>> getFavoriteVacancies() async {
    return await dataSourceStorage.getFavoriteVacancies();
  }

  @override
  Future<void> saveVacancyToFavorite(int vacancyId) async {
    await dataSourceStorage.saveVacancyToFavorite(vacancyId);
  }

  @override
  Future<void> deleteVacancyFromFavorite(int vacancyId) async {
    await dataSourceStorage.deleteVacancyFromFavorite(vacancyId);
  }

  /// Favorite company method
  @override
  Future<List<int>> getFavoriteCompanies() async {
    return await dataSourceStorage.getFavoriteCompanies();
  }

  @override
  Future<void> saveCompanyToFavorite(int companyId) async {
    await dataSourceStorage.saveCompanyToFavorite(companyId);
  }

  @override
  Future<void> deleteCompanyFromFavorite(int companyId) async {
    await dataSourceStorage.deleteCompanyFromFavorite(companyId);
  }

  @override
  Future<Either<Failure, List<Vacancy>>> getVacanciesList({
    required bool favoritesOnly,
    required VacanciesSortElement sortElement,
  }) async {
    final vacancies = await dataSourceRemote.getVacanciesList();
    if (vacancies == null) {
      return Left(ServerFailure());
    } else {
      var result = await _setFavoriteVacancy(vacancies);
      result = _vacanciesFavoriteFilter(result, favoritesOnly);
      result = _sortVacancies(result, sortElement);
      return Right(result);
    }
  }

  /// MARK: Private Method
  Future<List<Vacancy>> _setFavoriteVacancy(List<Vacancy> vacancies) async {
    final favoriteIds = await getFavoriteVacancies();
    for (final vacancy in vacancies) {
      if (favoriteIds.contains(vacancy.id)) {
        vacancy.isFavorite = true;
      }
    }
    return [...vacancies];
  }

  List<Vacancy> _vacanciesFavoriteFilter(
    List<Vacancy> vacancies,
    bool favoritesOnly,
  ) {
    if (favoritesOnly) {
      return [...vacancies.where((vacancy) => vacancy.isFavorite == true)];
    } else {
      return [...vacancies];
    }
  }

  List<Vacancy> _sortVacancies(
    List<Vacancy> vacancies,
    VacanciesSortElement sortElement,
  ) {
    switch (sortElement) {
      case VacanciesSortElement.title:
        vacancies.sort((a, b) => a.title.compareTo(b.title));
        break;
      case VacanciesSortElement.city:
        vacancies.sort((a, b) => a.city.compareTo(b.city));
        break;
    }
    return vacancies;
  }
}
