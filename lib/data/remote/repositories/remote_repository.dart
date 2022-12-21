import 'package:jobsin/domain/repositories/repository.dart';

import '../../../../domain/model/company.dart';
import '../../../../domain/model/vacancy.dart';
import '../datasources/remote_data_source.dart';

class RemoteRepository extends Repository {
  RemoteDataSource dataSource = RemoteDataSource();

  @override
  Future<List<Company>> getCompanies() async {
    final companyResponse = await dataSource.getCompanies();
    return companyResponse?.companies ?? [];
  }

  @override
  Future<List<Vacancy>> getVacancies() async {
    final vacancyResponse = await dataSource.getVacancies();
    return vacancyResponse?.vacancies ?? [];
  }

  @override
  Future<List<Vacancy>> getVacanciesForCompany(int companyId) async {
    final vacancyResponse = await dataSource.getVacanciesForCompany(companyId);
    return vacancyResponse?.vacancies ?? [];
  }
}
