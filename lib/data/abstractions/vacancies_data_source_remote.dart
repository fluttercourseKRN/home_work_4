import '../../domain/entities/vacancy.dart';
import '../models/vacancy_model.dart';

abstract class VacanciesDataSourceRemote {
  Future<int> addVacancy(Vacancy vacancy);
  Future<int> deleteVacancy(int vacancyId);

  Future<List<VacancyModel>?> getVacancies({
    List<int>? fetchOnlyCompaniesId,
  });
}
