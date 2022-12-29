import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/vacancy.dart';
import '../../domain/model/enums/vacancies_sort_element.dart';
import '../../domain/repositories/vacancies_repository.dart';
import '../abstractions/vacancies_data_source_remote.dart';
import '../abstractions/vacancies_data_source_storage.dart';

class VacanciesRepositoryImpl extends VacanciesRepository {
  final VacanciesDataSourceRemote dataSourceRemote;
  final VacanciesDataSourceStorage dataSourceStorage;

  VacanciesRepositoryImpl({
    required this.dataSourceRemote,
    required this.dataSourceStorage,
  });

  @override
  Future<Either<Failure, List<Vacancy>>> getVacanciesList({
    required bool favoritesOnly,
    required VacanciesSortElement sortElement,
    List<int>? fetchOnlyCompaniesId,
  }) async {
    final vacancies = await dataSourceRemote.getVacancies(
      fetchOnlyCompaniesId: fetchOnlyCompaniesId,
    );
    if (vacancies == null) {
      return Left(ServerFailure());
    } else {
      var result = await _setFavoriteVacancy(vacancies);
      result = await _setMyVacancy(result);
      result = _vacanciesFavoriteFilter(result, favoritesOnly);
      result = _sortVacancies(result, sortElement);
      return Right(result);
    }
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

  @override
  Future<Either<Failure, bool>> addVacancy(Vacancy vacancy) async {
    int vacancyId;
    try {
      vacancyId = await dataSourceRemote.addVacancy(vacancy);
    } catch (e) {
      return Left(ServerFailure());
    }
    try {
      await dataSourceStorage.addVacancy(vacancyId);
    } catch (e) {
      return Left(StorageFailure());
    }
    return const Right(true);
  }

  @override
  Future<Either<Failure, bool>> deleteVacancy(
    int vacancyId,
  ) async {
    try {
      await dataSourceRemote.deleteVacancy(vacancyId);
    } catch (e) {
      return Left(ServerFailure());
    }
    try {
      await dataSourceStorage.deleteVacancy(vacancyId);
    } catch (e) {
      return Left(StorageFailure());
    }
    return const Right(true);
  }

  @override
  Future<Either<Failure, List<Vacancy>>> getMyVacancies() async {
    final List<int> myVacancyIds;
    try {
      myVacancyIds = await _getMyVacanciesIds();
    } catch (e) {
      return Left(StorageFailure());
    }
    try {
      final result = await dataSourceRemote.getVacancies();
      if (result != null) {
        final filterResult = result
            .where((element) => myVacancyIds.contains(element.id))
            .toList();
        return Right(filterResult);
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> editVacancy(Vacancy vacancy) async {
    int deleteId;
    int addId;
    try {
      deleteId = await dataSourceRemote.deleteVacancy(vacancy.id);
      addId = await dataSourceRemote.addVacancy(vacancy);
    } catch (e) {
      return Left(ServerFailure());
    }
    try {
      await dataSourceStorage.deleteVacancy(deleteId);
      await dataSourceStorage.addVacancy(addId);
    } catch (e) {
      return Left(StorageFailure());
    }
    return const Right(true);
  }
}

extension HelpersPart on VacanciesRepositoryImpl {
  List<Vacancy> _sortVacancies(
    List<Vacancy> vacancies,
    VacanciesSortElement sortElement,
  ) {
    switch (sortElement) {
      case VacanciesSortElement.none:
        vacancies.sort((a, b) => b.isOwner ? 1 : -1);
        break;
      case VacanciesSortElement.title:
        vacancies.sort((a, b) {
          if (a.isOwner == b.isOwner) {
            return a.title.compareTo(b.title);
          } else {
            return b.isOwner ? 1 : -1;
          }
        });
        break;
      case VacanciesSortElement.city:
        vacancies.sort((a, b) {
          if (a.isOwner == b.isOwner) {
            return a.city.compareTo(b.city);
          } else {
            return b.isOwner ? 1 : -1;
          }
        });
        break;
    }
    return [...vacancies];
  }

  Future<List<Vacancy>> _setFavoriteVacancy(List<Vacancy> vacancies) async {
    final favoriteIds = await _getFavoriteVacanciesIds();
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

  Future<List<Vacancy>> _setMyVacancy(List<Vacancy> vacancies) async {
    final myVacancyIds = await _getMyVacanciesIds();
    for (final vacancy in vacancies) {
      if (myVacancyIds.contains(vacancy.id)) {
        vacancy.isOwner = true;
      }
    }
    return [...vacancies];
  }

  Future<List<int>> _getFavoriteVacanciesIds() async {
    return await dataSourceStorage.getFavoriteVacancies();
  }

  Future<List<int>> _getMyVacanciesIds() async {
    return await dataSourceStorage.getMyVacancies();
  }
}
