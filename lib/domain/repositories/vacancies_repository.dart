import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/vacancy.dart';
import '../model/enums/vacancies_sort_element.dart';

abstract class VacanciesRepository {
  Future<List<Vacancy>> getVacancies();
  Future<List<Vacancy>> getVacanciesForCompany(int companyId);

  Future<void> saveVacancyToFavorite(int vacancyId);
  Future<void> deleteVacancyFromFavorite(int vacancyId);
  Future<List<int>> getFavoriteVacanciesIds();

  Future<Either<Failure, List<Vacancy>>> getVacanciesList({
    required bool favoritesOnly,
    required VacanciesSortElement sortElement,
  });
}
