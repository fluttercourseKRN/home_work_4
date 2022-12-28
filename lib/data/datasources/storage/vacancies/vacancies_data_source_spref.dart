import 'package:jobsin/data/abstractions/vacancies_data_source_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/storage_helper.dart';

class VacanciesDataSourceSPref extends VacanciesDataSourceStorage {
  VacanciesDataSourceSPref(this.pref);
  final SharedPreferences pref;
  static const String _favoriteVacancyKey = 'favoriteVacancyKey';
  static const String _myVacancyKey = 'myVacancyKey';
  late final StorageHelper _helper = StorageHelper(pref);

  @override
  Future<void> saveVacancyToFavorite(int vacancyId) async {
    _helper.updateIntValues(value: vacancyId, key: _favoriteVacancyKey);
  }

  @override
  Future<List<int>> getFavoriteVacancies() async {
    return _helper.getIntValues(_favoriteVacancyKey);
  }

  @override
  Future<void> deleteVacancyFromFavorite(int vacancyId) async {
    _helper.deleteItnValue(value: vacancyId, key: _favoriteVacancyKey);
  }

  @override
  Future<void> addVacancy(int vacancyId) async {
    _helper.updateIntValues(value: vacancyId, key: _myVacancyKey);
    print(await getMyVacancies());
  }

  @override
  Future<void> deleteVacancy(int vacancyId) async {
    _helper.deleteItnValue(value: vacancyId, key: _myVacancyKey);
  }

  @override
  Future<List<int>> getMyVacancies() {
    return _helper.getIntValues(_myVacancyKey);
  }
}
