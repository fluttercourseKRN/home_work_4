import 'package:dartz/dartz.dart';
import 'package:jobsin/core/error/failure.dart';
import 'package:jobsin/core/use_case/use_case.dart';

import '../repositories/vacancies_repository.dart';

class VacancyFavoriteParams {
  final int vacancyId;
  final bool value;

  VacancyFavoriteParams({required this.vacancyId, required this.value});
}

class SetVacancyFavoriteStatus
    extends UseCase<NoParams, VacancyFavoriteParams> {
  SetVacancyFavoriteStatus(this.repository);
  final VacanciesRepository repository;

  @override
  Future<Either<Failure, NoParams>> call(VacancyFavoriteParams params) async {
    if (params.value) {
      repository.saveVacancyToFavorite(params.vacancyId);
    } else {
      repository.deleteVacancyFromFavorite(params.vacancyId);
    }
    return Right(NoParams());
  }
}
