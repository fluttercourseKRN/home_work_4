import 'package:jobsin/domain/entities/company.dart';

import '../models/company_model.dart';

abstract class CompaniesDataSourceRemote {
  Future<int> addCompany(Company company);
  Future<int> deleteCompany(int companyId);
  Future<List<CompanyModel>?> getCompanies({
    List<int>? fetchOnlyCompaniesId,
  });
}
