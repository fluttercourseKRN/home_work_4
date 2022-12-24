import '../datasources/remote/model/company_api_response.dart';
import '../datasources/remote/model/vacancy_api_response.dart';

abstract class DataSourceRemote {
  Future<CompanyApiResponse?> getCompanies();
  Future<VacancyApiResponse?> getVacancies();
  Future<VacancyApiResponse?> getVacanciesForCompany(int companyId);
  void post();
}
