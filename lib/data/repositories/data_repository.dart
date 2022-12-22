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
  Future<void> saveVacancyToFavorite(Vacancy vacancy);
  Future<void> saveCompanyToFavorite(Company vacancy);
  Future<List<Vacancy>> getFavoriteVacancies();
  Future<List<Vacancy>> getFavoriteCompanies();
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
}
