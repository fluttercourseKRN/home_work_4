import 'package:dartz/dartz.dart';
import 'package:jobsin/core/error/failure.dart';
import 'package:jobsin/core/use_case/use_case.dart';
import 'package:jobsin/domain/repositories/companies_repository.dart';

import '../entities/company.dart';

class AddCompanyParam {
  final Company company;

  AddCompanyParam({required this.company});
}

class AddCompany extends UseCase<bool, AddCompanyParam> {
  AddCompany(this.repository);
  final CompaniesRepository repository;

  @override
  Future<Either<Failure, bool>> call(AddCompanyParam params) {
    return repository.addCompany(params.company);
  }
}
