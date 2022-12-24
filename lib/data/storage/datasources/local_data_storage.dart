import 'package:jobsin/domain/entities/company.dart';
import 'package:jobsin/domain/entities/vacancy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repositories/data_storage.dart';

class LocalDataStorage with DataStorage {
  LocalDataStorage._internal();
  static final LocalDataStorage _instance = LocalDataStorage._internal();

  static Future<LocalDataStorage> init() async {
    _instance.pref = await SharedPreferences.getInstance();
    return _instance;
  }

  late final SharedPreferences pref;
  static const String _favoriteVacancyKey = 'favoriteVacancyKey';
  static const String _favoriteCompanyKey = 'favoriteCompanyKey';

  @override
  Future<void> saveVacancyToFavorite(int vacancyId) async {
    final favIds = _instance.pref.getStringList(_favoriteVacancyKey) ?? [];
    favIds.add('$vacancyId');
    await _instance.pref.setStringList(_favoriteVacancyKey, favIds);
  }

  @override
  Future<List<int>> getFavoriteVacancies() async {
    final favVacancies =
        _instance.pref.getStringList(_favoriteVacancyKey) ?? [];
    return favVacancies.map((e) => int.parse(e)).toList();
  }

  @override
  Future<void> deleteVacancyFromFavorite(int vacancyId) async {
    final favIds = _instance.pref.getStringList(_favoriteVacancyKey) ?? [];
    if (favIds.isNotEmpty) {
      favIds.remove('$vacancyId');
      await _instance.pref.setStringList(_favoriteVacancyKey, favIds);
    }
  }

  @override
  Future<List<int>> getFavoriteCompanies() async {
    final favCompanies =
        _instance.pref.getStringList(_favoriteCompanyKey) ?? [];
    return favCompanies.map((e) => int.parse(e)).toList();
  }

  @override
  Future<void> saveCompanyToFavorite(int companyId) async {
    final favIds = _instance.pref.getStringList(_favoriteCompanyKey) ?? [];
    favIds.add('$companyId');
    await _instance.pref.setStringList(_favoriteCompanyKey, favIds);
  }

  @override
  Future<void> deleteCompanyFromFavorite(int companyId) async {
    final favIds = _instance.pref.getStringList(_favoriteCompanyKey) ?? [];
    if (favIds.isNotEmpty) {
      favIds.remove('$companyId');
      await _instance.pref.setStringList(_favoriteCompanyKey, favIds);
    }
  }

  @override
  List<Company> loadCompanies() {
    // TODO: implement loadCompanies
    throw UnimplementedError();
  }

  @override
  List<Vacancy> loadVacancies() {
    // TODO: implement loadVacancies
    throw UnimplementedError();
  }

  @override
  void saveVacancy(Vacancy vacancy) {
    // TODO: implement saveVacancy
  }

  @override
  void saveCompany(Company company) {
    // TODO: implement saveCompany
  }
}
