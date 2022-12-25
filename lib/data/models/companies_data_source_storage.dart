abstract class CompaniesDataSourceStorage {
  Future<void> saveCompanyToFavorite(int companyId);

  Future<void> deleteCompanyFromFavorite(int companyId);

  Future<List<int>> getFavoriteCompanies();
}
