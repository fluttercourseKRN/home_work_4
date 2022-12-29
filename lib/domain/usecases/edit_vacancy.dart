import 'package:dartz/dartz.dart';
import 'package:jobsin/core/error/failure.dart';
import 'package:jobsin/core/use_case/use_case.dart';
import 'package:jobsin/domain/repositories/vacancies_repository.dart';

import '../entities/vacancy.dart';

class EditVacancyParam {
  final Vacancy vacancy;

  EditVacancyParam({required this.vacancy});
}

class EditVacancy extends UseCase<bool, EditVacancyParam> {
  final VacanciesRepository repository;

  EditVacancy(this.repository);
  @override
  Future<Either<Failure, bool>> call(EditVacancyParam params) {
    return repository.editVacancy(params.vacancy);
  }
}
