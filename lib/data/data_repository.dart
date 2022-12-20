import 'package:jobsin/domain/repositories/repository.dart';

import '../domain/model/company.dart';
import '../domain/model/vacancy.dart';

class DataRepository extends Repository {
  @override
  List<Company> getCompanies() {
    // TODO: implement getCompanies
    throw UnimplementedError();
  }

  @override
  List<Vacancy> getVacancies(String companyId) {
    // TODO: implement getVacancies
    throw UnimplementedError();
  }
}
