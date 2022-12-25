import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../core/use_case/use_case.dart';
import '../repositories/companies_repository.dart';

class CompanyFavoriteParams {
  final int companyId;
  final bool value;

  CompanyFavoriteParams({required this.companyId, required this.value});
}

class ToggleCompanyFavoriteStatus extends UseCase<bool, CompanyFavoriteParams> {
  ToggleCompanyFavoriteStatus(this.repository);
  final CompaniesRepository repository;

  @override
  Future<Either<Failure, bool>> call(CompanyFavoriteParams params) async {
    if (params.value) {
      return repository.saveCompanyToFavorite(params.companyId);
    } else {
      return repository.deleteCompanyFromFavorite(params.companyId);
    }
  }
}
