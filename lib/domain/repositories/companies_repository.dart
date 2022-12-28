import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/company.dart';
import '../model/enums/companies_sort_element.dart';

abstract class CompaniesRepository {
  Future<Either<Failure, List<Company>>> getCompaniesList({
    required bool favoritesOnly,
    required CompaniesSortElement sortElement,
  });
  Future<Either<Failure, List<Company>>> getMyCompanies();
  Future<Either<Failure, bool>> deleteCompany(int companyId);
  Future<Either<Failure, bool>> addCompany(Company company);
  Future<Either<Failure, bool>> saveCompanyToFavorite(int companyId);
  // Future<List<int>> getFavoriteCompaniesIds();
  Future<Either<Failure, bool>> deleteCompanyFromFavorite(int companyId);
}
