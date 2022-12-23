import 'package:jobsin/data/repositories/data_repository.dart';
import 'package:jobsin/domain/model/company.dart';
import 'package:jobsin/domain/model/vacancy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataStorage with DataStorage {
  LocalDataStorage._internal();
  static final LocalDataStorage _instance = LocalDataStorage._internal();

  static Future<LocalDataStorage> init() async {
    _instance.pref = await SharedPreferences.getInstance();
    return _instance;
  }

  late final SharedPreferences pref;
  static const String _favoriteVacancyKey = 'favoriteVacancyKey';

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
  Future<List<int>> getFavoriteCompanies() {
    // TODO: implement getFavoriteCompanies
    throw UnimplementedError();
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
  void saveCompany(Company company) {
    // TODO: implement saveCompany
  }

  @override
  Future<void> saveCompanyToFavorite(int vacancyId) {
    // TODO: implement saveCompanyToFavorite
    throw UnimplementedError();
  }

  @override
  void saveVacancy(Vacancy vacancy) {
    // TODO: implement saveVacancy
  }

  @override
  Future<void> deleteCompanyFromFavorite(int vacancyId) {
    // TODO: implement deleteCompanyFromFavorite
    throw UnimplementedError();
  }
}
