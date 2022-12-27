import 'package:dartz/dartz.dart';
import 'package:jobsin/core/error/failure.dart';
import 'package:jobsin/core/use_case/use_case.dart';
import 'package:jobsin/domain/repositories/vacancies_repository.dart';

class DeleteVacancyParam {
  final int vacancyId;

  DeleteVacancyParam({required this.vacancyId});
}

class DeleteVacancy extends UseCase<bool, DeleteVacancyParam> {
  DeleteVacancy(this.repository);
  final VacanciesRepository repository;

  @override
  Future<Either<Failure, bool>> call(DeleteVacancyParam params) {
    return repository.deleteVacancy(params.vacancyId);
  }
}
