import 'package:jobsin/data/models/vacancy_model.dart';

import '../datasources/remote/model/company_api_response.dart';

abstract class DataSourceRemote {
  Future<CompanyApiResponse?> getCompanies();
  Future<List<VacancyModel>?> getVacancies();
  Future<List<VacancyModel>?> getVacanciesForCompany(int companyId);
  Future<List<VacancyModel>?> getVacanciesList();
  void post();
}
