import '../model/company.dart';
import '../model/vacancy.dart';

abstract class Repository {
  Future<List<Company>> getCompanies();
  Future<List<Vacancy>> getVacancies();
  Future<List<Vacancy>> getVacanciesForCompany(int companyId);
}
