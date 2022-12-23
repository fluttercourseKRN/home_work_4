import 'package:jobsin/domain/repositories/repository.dart';

import '../../domain/model/entities/company.dart';
import '../../domain/model/entities/vacancy.dart';
import 'data_source.dart';
import 'data_storage.dart';

class DataRepository extends Repository {
  final DataSource dataSource;
  final DataStorage dataStorage;

  DataRepository({
    required this.dataSource,
    required this.dataStorage,
  });

  @override
  Future<List<Company>> getCompanies() async {
    final companyResponse = await dataSource.getCompanies();
    return companyResponse?.companies ?? [];
  }

  @override
  Future<List<Vacancy>> getVacancies() async {
    final vacancyResponse = await dataSource.getVacancies();
    final vacancies = vacancyResponse?.vacancies ?? [];
    return await _checkFavorite(vacancies);
  }

  @override
  Future<List<Vacancy>> getVacanciesForCompany(int companyId) async {
    final vacancyResponse = await dataSource.getVacanciesForCompany(companyId);
    final vacancies = vacancyResponse?.vacancies ?? [];
    return await _checkFavorite(vacancies);
  }

  /// Favorite vacancy method
  @override
  Future<List<int>> getFavoriteVacancies() async {
    return await dataStorage.getFavoriteVacancies();
  }

  @override
  Future<void> saveVacancyToFavorite(int vacancyId) async {
    await dataStorage.saveVacancyToFavorite(vacancyId);
  }

  @override
  Future<void> deleteVacancyFromFavorite(int vacancyId) async {
    await dataStorage.deleteVacancyFromFavorite(vacancyId);
  }

  Future<List<Vacancy>> _checkFavorite(List<Vacancy> vacancies) async {
    final favoriteIds = await getFavoriteVacancies();
    for (final vacancy in vacancies) {
      if (favoriteIds.contains(vacancy.id)) {
        vacancy.isFavorite = true;
      }
    }
    return [...vacancies];
  }

  /// Favorite company method
  @override
  Future<List<int>> getFavoriteCompanies() async {
    return await dataStorage.getFavoriteCompanies();
  }

  @override
  Future<void> saveCompanyToFavorite(int vacancyId) async {
    await dataStorage.saveCompanyToFavorite(vacancyId);
  }

  @override
  Future<void> deleteCompanyFromFavorite(int vacancyId) async {
    await dataStorage.deleteCompanyFromFavorite(vacancyId);
  }
}
