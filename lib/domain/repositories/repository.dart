import '../model/company.dart';
import '../model/vacancy.dart';

abstract class Repository {
  List<Company> getCompanies();
  List<Vacancy> getVacancies(String companyId);
}
