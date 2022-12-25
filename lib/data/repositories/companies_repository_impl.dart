import '../../domain/entities/company.dart';
import '../../domain/repositories/companies_repository.dart';
import '../models/companies_data_source_remote.dart';
import '../models/companies_data_source_storage.dart';

class CompaniesRepositoryImpl extends CompaniesRepository {
  final CompaniesDataSourceRemote dataSourceRemote;
  final CompaniesDataSourceStorage dataSourceStorage;

  CompaniesRepositoryImpl({
    required this.dataSourceRemote,
    required this.dataSourceStorage,
  });

  @override
  Future<List<Company>> getCompanies() async {
    final companyResponse = await dataSourceRemote.getCompanies();
    final companies = companyResponse ?? [];
    return await _setFavoriteCompany(companies);
  }

  Future<List<Company>> _setFavoriteCompany(List<Company> companies) async {
    final favoriteIds = await getFavoriteCompaniesIds();
    for (final company in companies) {
      if (favoriteIds.contains(company.id)) {
        company.isFavorite = true;
      }
    }
    return [...companies];
  }

  /// Favorite company method
  @override
  Future<List<int>> getFavoriteCompaniesIds() async {
    return await dataSourceStorage.getFavoriteCompanies();
  }

  @override
  Future<void> saveCompanyToFavorite(int companyId) async {
    await dataSourceStorage.saveCompanyToFavorite(companyId);
  }

  @override
  Future<void> deleteCompanyFromFavorite(int companyId) async {
    await dataSourceStorage.deleteCompanyFromFavorite(companyId);
  }
}
