import 'package:dartz/dartz.dart';
import 'package:jobsin/core/use_case/use_case.dart';

import '../../core/error/failure.dart';
import '../entities/vacancy.dart';
import '../model/enums/vacancies_sort_element.dart';
import '../repositories/repository.dart';

/// Params
class VacanciesParams {
  bool favoritesOnly;
  VacanciesSortElement sortElement;

  VacanciesParams({
    required this.favoritesOnly,
    required this.sortElement,
  });
}

/// UseCase
class GetVacanciesList extends UseCase<List<Vacancy>, VacanciesParams> {
  GetVacanciesList(this.repository);
  final Repository repository;

  @override
  Future<Either<Failure, List<Vacancy>>> call(VacanciesParams params) async {
    return repository.getVacanciesList(
      favoritesOnly: params.favoritesOnly,
      sortElement: params.sortElement,
    );
  }
}
