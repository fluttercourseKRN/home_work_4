abstract class CompaniesDataSourceStorage {
  Future<void> addCompany(int companyId);
  Future<void> deleteCompany(int companyId);
  Future<List<int>> getMyCompanies();

  Future<void> saveCompanyToFavorite(int companyId);
  Future<void> deleteCompanyFromFavorite(int companyId);
  Future<List<int>> getFavoriteCompanies();
}
