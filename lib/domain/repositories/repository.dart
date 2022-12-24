import '../entities/company.dart';
import '../entities/vacancy.dart';

abstract class Repository {
  Future<List<Company>> getCompanies();
  Future<List<Vacancy>> getVacancies();
  Future<List<Vacancy>> getVacanciesForCompany(int companyId);

  /// Favorite method
  Future<void> saveVacancyToFavorite(int vacancyId);
  Future<void> saveCompanyToFavorite(int companyId);
  Future<void> deleteVacancyFromFavorite(int vacancyId);
  Future<void> deleteCompanyFromFavorite(int companyId);
  Future<List<int>> getFavoriteVacancies();
  Future<List<int>> getFavoriteCompanies();
  // void saveCompany(Company company);
  // void saveVacancy(Vacancy vacancy);
  // List<Company> loadCompanies();
  // List<Vacancy> loadVacancies();
}
