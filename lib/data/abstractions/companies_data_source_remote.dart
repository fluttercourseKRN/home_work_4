import 'package:jobsin/domain/entities/company.dart';

import '../models/company_model.dart';

abstract class CompaniesDataSourceRemote {
  Future<List<CompanyModel>?> getCompanies();
  Future<void> addCompany(Company company);
  Future<void> deleteCompany(int companyId);
}
