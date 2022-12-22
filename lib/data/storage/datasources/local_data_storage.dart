import 'package:jobsin/data/repositories/data_repository.dart';
import 'package:jobsin/domain/model/company.dart';
import 'package:jobsin/domain/model/vacancy.dart';

class LocalDataStorage extends DataStorage {
  @override
  Future<List<Vacancy>> getFavoriteCompanies() {
    // TODO: implement getFavoriteCompanies
    throw UnimplementedError();
  }

  @override
  Future<List<Vacancy>> getFavoriteVacancies() {
    // TODO: implement getFavoriteVacancies
    throw UnimplementedError();
  }

  @override
  List<Company> loadCompanies() {
    // TODO: implement loadCompanies
    throw UnimplementedError();
  }

  @override
  List<Vacancy> loadVacancies() {
    // TODO: implement loadVacancies
    throw UnimplementedError();
  }

  @override
  void saveCompany(Company company) {
    // TODO: implement saveCompany
  }

  @override
  Future<void> saveCompanyToFavorite(Company vacancy) {
    // TODO: implement saveCompanyToFavorite
    throw UnimplementedError();
  }

  @override
  void saveVacancy(Vacancy vacancy) {
    // TODO: implement saveVacancy
  }

  @override
  Future<void> saveVacancyToFavorite(Vacancy vacancy) {
    // TODO: implement saveVacancyToFavorite
    throw UnimplementedError();
  }
}
