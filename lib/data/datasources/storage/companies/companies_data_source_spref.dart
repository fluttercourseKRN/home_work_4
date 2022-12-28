import 'package:jobsin/data/abstractions/companies_data_source_storage.dart';
import 'package:jobsin/data/datasources/storage/model/storage_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompaniesDataSourceSPref extends CompaniesDataSourceStorage {
  CompaniesDataSourceSPref(this.pref);
  final SharedPreferences pref;
  static const String _favoriteCompanyKey = 'favoriteCompanyKey';
  static const String _myCompanyKey = 'myCompanyKey2';
  late final StorageHelper _helper = StorageHelper(pref);

  @override
  Future<void> saveCompanyToFavorite(int companyId) async {
    await _helper.updateIntValues(value: companyId, key: _favoriteCompanyKey);
  }

  @override
  Future<List<int>> getFavoriteCompanies() async {
    return _helper.getIntValues(_favoriteCompanyKey);
  }

  @override
  Future<void> deleteCompanyFromFavorite(int companyId) async {
    await _helper.deleteItnValue(value: companyId, key: _favoriteCompanyKey);
  }

  @override
  Future<void> addCompany(int companyId) async {
    _helper.updateIntValues(value: companyId, key: _myCompanyKey);
    // print(await getMyCompanies());
  }

  @override
  Future<void> deleteCompany(int companyId) async {
    _helper.deleteItnValue(value: companyId, key: _myCompanyKey);
  }

  @override
  Future<List<int>> getMyCompanies() async {
    return _helper.getIntValues(_myCompanyKey);
  }
}
