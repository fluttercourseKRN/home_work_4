import '../../domain/entities/vacancy.dart';
import '../models/vacancy_model.dart';

abstract class VacanciesDataSourceRemote {
  Future<void> addVacancy(Vacancy vacancy);
  Future<void> deleteVacancy(int vacancyId);

  Future<List<VacancyModel>?> getVacanciesForCompany(int companyId);
  Future<List<VacancyModel>?> getVacanciesList({
    List<int>? fetchOnlyCompaniesId,
  });
}
