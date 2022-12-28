import 'package:dartz/dartz.dart';
import 'package:jobsin/core/error/failure.dart';
import 'package:jobsin/core/use_case/use_case.dart';
import 'package:jobsin/domain/entities/vacancy.dart';
import 'package:jobsin/domain/repositories/vacancies_repository.dart';

class GetMyVacancies extends UseCase<List<Vacancy>, NoParams> {
  final VacanciesRepository repository;

  GetMyVacancies(this.repository);
  @override
  Future<Either<Failure, List<Vacancy>>> call(NoParams? params) {
    return repository.getMyVacancies();
  }
}
