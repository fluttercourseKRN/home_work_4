import 'vacancy_model.dart';

abstract class VacanciesDataSourceRemote {
  Future<List<VacancyModel>?> getVacanciesForCompany(int companyId);
  Future<List<VacancyModel>?> getVacanciesList({
    List<int>? fetchOnlyCompaniesId,
  });
}
