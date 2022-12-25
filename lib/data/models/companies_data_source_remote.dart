import 'company_model.dart';

abstract class CompaniesDataSourceRemote {
  Future<List<CompanyModel>?> getCompanies();
}
