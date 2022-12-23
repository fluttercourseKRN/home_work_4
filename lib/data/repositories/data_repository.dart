import 'package:jobsin/domain/repositories/repository.dart';

import '../../../../domain/model/company.dart';
import '../../../../domain/model/vacancy.dart';
import '../remote/model/company_api_response.dart';
import '../remote/model/vacancy_api_response.dart';

abstract class DataStorage {
  void saveCompany(Company company);
  void saveVacancy(Vacancy vacancy);
  List<Company> loadCompanies();
  List<Vacancy> loadVacancies();
  Future<void> saveVacancyToFavorite(int vacancyId);
  Future<void> saveCompanyToFavorite(int vacancyId);
  Future<void> deleteVacancyFromFavorite(int vacancyId);
  Future<void> deleteCompanyFromFavorite(int vacancyId);
  Future<List<int>> getFavoriteVacancies();
  Future<List<int>> getFavoriteCompanies();
}

abstract class DataSource {
  Future<CompanyApiResponse?> getCompanies();
  Future<VacancyApiResponse?> getVacancies();
  Future<VacancyApiResponse?> getVacanciesForCompany(int companyId);
  void post();
}

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
    return vacancyResponse?.vacancies ?? [];
  }

  @override
  Future<List<Vacancy>> getVacanciesForCompany(int companyId) async {
    final vacancyResponse = await dataSource.getVacanciesForCompany(companyId);
    return vacancyResponse?.vacancies ?? [];
  }

  @override
  Future<List<int>> getFavoriteVacancies() async {
    return [];
  }

  @override
  Future<void> saveVacancyToFavorite(int vacancyId) {
    // TODO: implement saveVacancyToFavorite
    throw UnimplementedError();
  }

  @override
  Future<void> saveCompanyToFavorite(int vacancyId) {
    // TODO: implement saveCompanyToFavorite
    throw UnimplementedError();
  }

  @override
  Future<void> deleteVacancyFromFavorite(int vacancyId) {
    // TODO: implement deleteVacancyFromFavorite
    throw UnimplementedError();
  }

  @override
  Future<List<int>> getFavoriteCompanies() {
    // TODO: implement getFavoriteCompanies
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCompanyFromFavorite(int vacancyId) {
    // TODO: implement deleteCompanyFromFavorite
    throw UnimplementedError();
  }
}
