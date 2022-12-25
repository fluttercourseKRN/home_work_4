import '../entities/company.dart';

abstract class CompaniesRepository {
  Future<List<Company>> getCompanies();

  /// Favorite method

  Future<void> saveCompanyToFavorite(int companyId);
  Future<List<int>> getFavoriteCompaniesIds();
  Future<void> deleteCompanyFromFavorite(int companyId);
}
