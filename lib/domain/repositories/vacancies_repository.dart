import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/vacancy.dart';
import '../model/enums/vacancies_sort_element.dart';

abstract class VacanciesRepository {
  Future<List<Vacancy>> getVacanciesForCompany(int companyId);
  Future<List<int>> getFavoriteVacanciesIds();

  Future<Either<Failure, bool>> saveVacancyToFavorite(int vacancyId);
  Future<Either<Failure, bool>> deleteVacancyFromFavorite(int vacancyId);
  Future<Either<Failure, List<Vacancy>>> getVacanciesList({
    required bool favoritesOnly,
    required VacanciesSortElement sortElement,
  });
}
