import 'package:dartz/dartz.dart';
import 'package:jobsin/core/error/failure.dart';
import 'package:jobsin/domain/entities/vacancy.dart';
import 'package:jobsin/domain/repositories/repository.dart';

class GetVacanciesList {
  GetVacanciesList(this.repository);
  final Repository repository;

  Future<Either<Failure, List<Vacancy>>> execute() async {}
}
