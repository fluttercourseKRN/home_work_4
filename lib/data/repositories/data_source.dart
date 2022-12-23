import '../remote/model/company_api_response.dart';
import '../remote/model/vacancy_api_response.dart';

abstract class DataSource {
  Future<CompanyApiResponse?> getCompanies();
  Future<VacancyApiResponse?> getVacancies();
  Future<VacancyApiResponse?> getVacanciesForCompany(int companyId);
  void post();
}
