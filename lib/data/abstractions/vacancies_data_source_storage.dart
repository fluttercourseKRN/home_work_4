import '../../domain/entities/vacancy.dart';

abstract class VacanciesDataSourceStorage {
  Future<void> addVacancy(Vacancy vacancy);
  Future<void> deleteVacancy(int vacancyId);
  Future<List<int>> getMyVacancies();

  Future<void> saveVacancyToFavorite(int vacancyId);
  Future<void> deleteVacancyFromFavorite(int vacancyId);
  Future<List<int>> getFavoriteVacancies();
}
