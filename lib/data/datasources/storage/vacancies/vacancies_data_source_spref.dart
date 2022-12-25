import 'package:jobsin/data/models/vacancies_data_source_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VacanciesDataSourceSPref extends VacanciesDataSourceStorage {
  VacanciesDataSourceSPref(this.pref);
  final SharedPreferences pref;
  static const String _favoriteVacancyKey = 'favoriteVacancyKey';

  @override
  Future<void> saveVacancyToFavorite(int vacancyId) async {
    final favIds = pref.getStringList(_favoriteVacancyKey) ?? [];
    favIds.add('$vacancyId');
    await pref.setStringList(_favoriteVacancyKey, favIds);
  }

  @override
  Future<List<int>> getFavoriteVacancies() async {
    final favVacancies = pref.getStringList(_favoriteVacancyKey) ?? [];
    return favVacancies.map((e) => int.parse(e)).toList();
  }

  @override
  Future<void> deleteVacancyFromFavorite(int vacancyId) async {
    final favIds = pref.getStringList(_favoriteVacancyKey) ?? [];
    if (favIds.isNotEmpty) {
      favIds.remove('$vacancyId');
      await pref.setStringList(_favoriteVacancyKey, favIds);
    }
  }
}
