import 'package:dartz/dartz.dart';
import 'package:jobsin/core/error/failure.dart';
import 'package:jobsin/core/use_case/use_case.dart';
import 'package:jobsin/domain/entities/vacancy.dart';
import 'package:jobsin/domain/repositories/vacancies_repository.dart';

class AddVacancyParam {
  final Vacancy vacancy;

  AddVacancyParam({required this.vacancy});
}

class AddVacancy extends UseCase<bool, AddVacancyParam> {
  AddVacancy(this.repository);
  final VacanciesRepository repository;

  @override
  Future<Either<Failure, bool>> call(AddVacancyParam params) {
    return repository.addVacancy(params.vacancy);
  }
}
