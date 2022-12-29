import 'package:dartz/dartz.dart';
import 'package:jobsin/domain/repositories/companies_repository.dart';

import '../../core/error/failure.dart';
import '../../core/use_case/use_case.dart';
import '../entities/company.dart';

class EditCompanyParam {
  final Company company;

  EditCompanyParam({required this.company});
}

class EditCompany extends UseCase<bool, EditCompanyParam> {
  final CompaniesRepository repository;

  EditCompany(this.repository);
  @override
  Future<Either<Failure, bool>> call(EditCompanyParam params) {
    return repository.editCompany(params.company);
  }
}
