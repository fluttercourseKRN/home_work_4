import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/vacancy.dart';
import '../model/enums/vacancies_sort_element.dart';

abstract class VacanciesRepository {
  Future<Either<Failure, List<Vacancy>>> getVacanciesList({
    required bool favoritesOnly,
    required VacanciesSortElement sortElement,
    List<int>? fetchOnlyCompaniesId,
  });
  Future<Either<Failure, List<Vacancy>>> getMyVacancies();
  Future<Either<Failure, bool>> deleteVacancy(int vacancyId);
  Future<Either<Failure, bool>> addVacancy(Vacancy vacancy);
  Future<Either<Failure, bool>> saveVacancyToFavorite(int vacancyId);
  Future<Either<Failure, bool>> deleteVacancyFromFavorite(int vacancyId);
}
