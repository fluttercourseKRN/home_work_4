abstract class VacanciesDataSourceStorage {
  Future<void> saveVacancyToFavorite(int vacancyId);
  Future<void> deleteVacancyFromFavorite(int vacancyId);
  Future<List<int>> getFavoriteVacancies();
}
