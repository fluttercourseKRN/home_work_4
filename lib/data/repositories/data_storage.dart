import '../../domain/model/entities/company.dart';
import '../../domain/model/entities/vacancy.dart';

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
