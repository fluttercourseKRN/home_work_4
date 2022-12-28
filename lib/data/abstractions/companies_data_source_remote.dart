import 'package:jobsin/domain/entities/company.dart';

import '../models/company_model.dart';

abstract class CompaniesDataSourceRemote {
  Future<List<CompanyModel>?> getCompanies();
  Future<int> addCompany(Company company);
  Future<bool> deleteCompany(int companyId);
}
