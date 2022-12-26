import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/vacancy.dart';
import '../../domain/model/enums/vacancies_sort_element.dart';
import '../../domain/repositories/vacancies_repository.dart';
import '../models/vacancies_data_source_remote.dart';
import '../models/vacancies_data_source_storage.dart';

class VacanciesRepositoryImpl extends VacanciesRepository {
  final VacanciesDataSourceRemote dataSourceRemote;
  final VacanciesDataSourceStorage dataSourceStorage;

  VacanciesRepositoryImpl({
    required this.dataSourceRemote,
    required this.dataSourceStorage,
  });

  @override
  Future<List<Vacancy>> getVacanciesForCompany(int companyId) async {
    final vacancyResponse =
        await dataSourceRemote.getVacanciesForCompany(companyId);
    final vacancies = vacancyResponse ?? [];
    return await _setFavoriteVacancy(vacancies);
  }

  /// Favorite vacancy method
  @override
  Future<List<int>> getFavoriteVacanciesIds() async {
    return await dataSourceStorage.getFavoriteVacancies();
  }

  @override
  Future<Either<Failure, List<Vacancy>>> getVacanciesList({
    required bool favoritesOnly,
    required VacanciesSortElement sortElement,
    List<int>? fetchOnlyCompaniesId,
  }) async {
    final vacancies = await dataSourceRemote.getVacanciesList(
      fetchOnlyCompaniesId: fetchOnlyCompaniesId,
    );
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
    final favoriteIds = await getFavoriteVacanciesIds();
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
      case VacanciesSortElement.none:
        break;
      case VacanciesSortElement.title:
        vacancies.sort((a, b) => a.title.compareTo(b.title));
        break;
      case VacanciesSortElement.city:
        vacancies.sort((a, b) => a.city.compareTo(b.city));
        break;
    }
    return [...vacancies];
  }

  @override
  Future<Either<Failure, bool>> saveVacancyToFavorite(int vacancyId) async {
    try {
      await dataSourceStorage.saveVacancyToFavorite(vacancyId);
      return const Right(true);
    } catch (e) {
      return Left(StorageFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteVacancyFromFavorite(int vacancyId) async {
    try {
      await dataSourceStorage.deleteVacancyFromFavorite(vacancyId);
      return const Right(false);
    } catch (e) {
      return Left(StorageFailure());
    }
  }
}
