import 'package:dartz/dartz.dart';
import 'package:jobsin/core/error/failure.dart';
import 'package:jobsin/core/use_case/use_case.dart';

import '../repositories/vacancies_repository.dart';

class VacancyFavoriteParams {
  final int vacancyId;
  final bool value;

  VacancyFavoriteParams({required this.vacancyId, required this.value});
}

class ToggleVacancyFavoriteStatus extends UseCase<bool, VacancyFavoriteParams> {
  ToggleVacancyFavoriteStatus(this.repository);
  final VacanciesRepository repository;

  @override
  Future<Either<Failure, bool>> call(VacancyFavoriteParams params) async {
    if (params.value) {
      return repository.saveVacancyToFavorite(params.vacancyId);
    } else {
      return repository.deleteVacancyFromFavorite(params.vacancyId);
    }
  }
}
