import 'package:dartz/dartz.dart';
import 'package:jobsin/core/error/failure.dart';
import 'package:jobsin/domain/repositories/repository.dart';

import '../../domain/entities/company.dart';
import '../../domain/entities/vacancy.dart';
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
    final vacancies = vacancyResponse?.vacancies ?? [];
    return await _setFavoriteVacancy(vacancies);
  }

  @override
  Future<List<Vacancy>> getVacanciesForCompany(int companyId) async {
    final vacancyResponse =
        await dataSourceRemote.getVacanciesForCompany(companyId);
    final vacancies = vacancyResponse?.vacancies ?? [];
    return await _setFavoriteVacancy(vacancies);
  }

  Future<List<Vacancy>> _setFavoriteVacancy(List<Vacancy> vacancies) async {
    final favoriteIds = await getFavoriteVacancies();
    for (final vacancy in vacancies) {
      if (favoriteIds.contains(vacancy.id)) {
        vacancy.isFavorite = true;
      }
    }
    return [...vacancies];
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
  Future<Either<Failure, List<Vacancy>>> getVacanciesList() async {
    final vacancies = await dataSourceRemote.getVacanciesList();
    if (vacancies == null) {
      return Left(ServerFailure());
    } else {
      return Right(vacancies);
    }
  }
}
