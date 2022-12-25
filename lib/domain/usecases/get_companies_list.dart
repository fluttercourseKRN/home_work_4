import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../core/use_case/use_case.dart';
import '../entities/company.dart';
import '../model/enums/companies_sort_element.dart';
import '../repositories/companies_repository.dart';

/// Params
class CompaniesParams {
  final bool favoritesOnly;
  final CompaniesSortElement sortElement;
  final int? companyId;

  CompaniesParams({
    required this.favoritesOnly,
    required this.sortElement,
    this.companyId,
  });
}

/// UseCase
class GetVacanciesList extends UseCase<List<Company>, CompaniesParams> {
  GetVacanciesList(this.repository);
  final CompaniesRepository repository;

  @override
  Future<Either<Failure, List<Company>>> call(CompaniesParams params) async {
    // print('${params.sortElement} ${params.favoritesOnly}');
    return repository.getCompaniesList(
      favoritesOnly: params.favoritesOnly,
      sortElement: params.sortElement,
    );
  }
}
