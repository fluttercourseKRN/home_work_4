import 'package:dartz/dartz.dart';
import 'package:jobsin/core/use_case/use_case.dart';
import 'package:jobsin/domain/repositories/vacancies_repository.dart';

import '../../core/error/failure.dart';
import '../entities/vacancy.dart';
import '../model/enums/vacancies_sort_element.dart';

/// Params
class VacanciesParams {
  final bool favoritesOnly;
  final VacanciesSortElement sortElement;
  final int? companyId;

  VacanciesParams({
    required this.favoritesOnly,
    required this.sortElement,
    this.companyId,
  });
}

/// UseCase
class GetVacanciesList extends UseCase<List<Vacancy>, VacanciesParams> {
  GetVacanciesList(this.repository);
  final VacanciesRepository repository;

  @override
  Future<Either<Failure, List<Vacancy>>> call(VacanciesParams params) async {
    // print('${params.sortElement} ${params.favoritesOnly}');
    return repository.getVacanciesList(
      favoritesOnly: params.favoritesOnly,
      sortElement: params.sortElement,
    );
  }
}
