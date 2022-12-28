import 'package:dartz/dartz.dart';
import 'package:jobsin/core/error/failure.dart';
import 'package:jobsin/core/use_case/use_case.dart';
import 'package:jobsin/domain/entities/company.dart';
import 'package:jobsin/domain/repositories/companies_repository.dart';

class GetMyCompanies extends UseCase<List<Company>, NoParams> {
  final CompaniesRepository repository;

  GetMyCompanies(this.repository);
  @override
  Future<Either<Failure, List<Company>>> call(NoParams? params) async {
    return repository.getMyCompanies();
  }
}
