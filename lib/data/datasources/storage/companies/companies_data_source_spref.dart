import 'package:jobsin/data/models/companies_data_source_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompaniesDataSourceSPref extends CompaniesDataSourceStorage {
  CompaniesDataSourceSPref(this.pref);
  final SharedPreferences pref;
  static const String _favoriteCompanyKey = 'favoriteCompanyKey';

  @override
  Future<void> saveCompanyToFavorite(int companyId) async {
    print("object");
    final favIds = pref.getStringList(_favoriteCompanyKey) ?? [];
    favIds.add('$companyId');
    print(favIds);
    await pref.setStringList(_favoriteCompanyKey, favIds);
  }

  @override
  Future<List<int>> getFavoriteCompanies() async {
    final favCompanies = pref.getStringList(_favoriteCompanyKey) ?? [];
    return favCompanies.map((e) => int.parse(e)).toList();
  }

  @override
  Future<void> deleteCompanyFromFavorite(int companyId) async {
    final favIds = pref.getStringList(_favoriteCompanyKey) ?? [];
    if (favIds.isNotEmpty) {
      favIds.remove('$companyId');
      await pref.setStringList(_favoriteCompanyKey, favIds);
    }
  }
}
