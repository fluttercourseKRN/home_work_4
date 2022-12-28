abstract class VacanciesDataSourceStorage {
  Future<void> addVacancy(int vacancyId);
  Future<void> deleteVacancy(int vacancyId);
  Future<List<int>> getMyVacancies();

  Future<void> saveVacancyToFavorite(int vacancyId);
  Future<void> deleteVacancyFromFavorite(int vacancyId);
  Future<List<int>> getFavoriteVacancies();
}
