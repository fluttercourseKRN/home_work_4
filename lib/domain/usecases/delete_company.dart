import 'package:dartz/dartz.dart';
import 'package:jobsin/core/error/failure.dart';
import 'package:jobsin/core/use_case/use_case.dart';
import 'package:jobsin/domain/repositories/companies_repository.dart';

class DeleteCompanyParam {
  final int companyId;

  DeleteCompanyParam({required this.companyId});
}

class DeleteCompany extends UseCase<bool, DeleteCompanyParam> {
  DeleteCompany(this.repository);
  final CompaniesRepository repository;

  @override
  Future<Either<Failure, bool>> call(DeleteCompanyParam params) {
    return repository.deleteCompany(params.companyId);
  }
}
